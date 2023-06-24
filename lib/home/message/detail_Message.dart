import 'package:chat_app/config/changedNotify/detail_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailMessage extends StatefulWidget {
  const DetailMessage(
      {Key? key, this.uid, this.chatRoomId, this.name, this.avatar, this.token})
      : super(key: key);

  final String? uid;
  final String? chatRoomId;
  final String? name;
  final String? avatar;
  final String? token;

  @override
  State<StatefulWidget> createState() {
    return DetailMessageState();
  }
}

class DetailMessageState extends State<DetailMessage> {
  Stream<QuerySnapshot>? chats;
  DateFormat timeFormat = DateFormat('HH:mm a');
  DateFormat dateFormat = DateFormat('MMM dd, HH:mm');

  bool checkTime(DateTime dateTime) {
    DateTime timeCurrent = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(dateTime);
    String dateCurrent = DateFormat('yyyy-MM-dd').format(timeCurrent);
    if (date == dateCurrent) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChat();
  }

  getChat() async {
    await context
        .read<DetailMessageProvider>()
        .getChats(widget.chatRoomId!)
        .then((value) {
      setState(() {
        chats = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36), topRight: Radius.circular(36))),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Head(),
              Today(),
              Expanded(child: ListMessage()),
              ControllMessage(),
              if (context.watch<DetailMessageProvider>().showEmoji) Emoji()
            ],
          );
        }),
      ),
    );
  }

  Widget Head() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10, top: 20, bottom: 10),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(widget.avatar.toString()),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.name}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Text(
                'Online',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_rounded),
          ),
        ),
      ],
    );
  }

  Widget Today() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // Căn giữa theo chiều ngang
        children: const [
          Expanded(
            child: Divider(color: Colors.black), // Đường viền
          ),
        ]);
  }

  Widget ListMessage() {
    return StreamBuilder(
        stream: chats,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  padding: const EdgeInsets.only(top: 10),
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    DateTime time =
                        DateTime.parse(snapshot.data?.docs[index]['time']);
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Column(
                        children: [
                          checkTime(time)
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dateFormat.format(time),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                          Align(
                            alignment:
                                (snapshot.data?.docs[index]['uid'] != widget.uid
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                            child: Column(
                              crossAxisAlignment: snapshot.data?.docs[index]
                                          ['uid'] ==
                                      widget.uid
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: snapshot
                                              .data!.docs[index]['messageText']
                                              .toString()
                                              .length >
                                          20
                                      ? MediaQuery.of(context).size.width / 2
                                      : null,
                                  decoration: BoxDecoration(
                                    borderRadius: snapshot.data?.docs[index]
                                                ['imageURL'] !=
                                            ''
                                        ? const BorderRadius.all(
                                            Radius.circular(10))
                                        : snapshot.data?.docs[index]['uid'] ==
                                                widget.uid
                                            ? const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10))
                                            : const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                    color: (snapshot.data?.docs[index]['uid'] !=
                                            widget.uid
                                        ? const Color.fromARGB(
                                            255, 248, 222, 225)
                                        : Colors.grey.shade300),
                                  ),
                                  padding: snapshot.data?.docs[index]
                                              ['imageURL'] !=
                                          ''
                                      ? EdgeInsets.zero
                                      : const EdgeInsets.all(16),
                                  child: snapshot.data?.docs[index]
                                              ['imageURL'] !=
                                          ''
                                      ? _Image(snapshot.data!.docs[index]
                                          ['imageURL'])
                                      : Text(
                                          snapshot.data?.docs[index]
                                              ['messageText'],
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                ),
                                checkTime(time)
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          timeFormat.format(time),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Container();
        });
  }

  Widget Emoji() {
    return Container(
      color: Colors.teal,
      height: MediaQuery.of(context).size.height * 0.3,
      child: EmojiPicker(
        textEditingController:
            context.watch<DetailMessageProvider>().messageController,
        onBackspacePressed: () {
          // Do something when the user taps the backspace button (optional)
          // Set it to null to hide the Backspace-Button
        },
        //textEditingController: textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: Config(
          columns: 7,
          bgColor: Colors.white,
          emojiSizeMax: 32 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.30
                  : 1.0),
        ),
      ),
    );
  }

  Widget ControllMessage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16, bottom: 10),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    context.watch<DetailMessageProvider>().image != null
                        ? selectedImage()
                        : textField_emoji(),
                    context.watch<DetailMessageProvider>().image != null
                        ? const Spacer()
                        : Container(),
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {
                          await context
                              .read<DetailMessageProvider>()
                              .pickImage();
                          if (context.read<DetailMessageProvider>().showEmoji) {
                            context.read<DetailMessageProvider>().setShowEmoji(
                                !context
                                    .read<DetailMessageProvider>()
                                    .showEmoji);
                          }
                        },
                        icon: const Icon(
                          Icons.image,
                        ))
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  context.read<DetailMessageProvider>().addMessage(
                      widget.chatRoomId!, widget.uid!, widget.token!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField_emoji() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: TextField(
                controller:
                    context.watch<DetailMessageProvider>().messageController,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  // setState(() {
                  //   if (value.length > 100) {
                  //     maxLines = 4;
                  //   } else {
                  //     maxLines = null;
                  //   }
                  // });
                },
                //maxLines: maxLines,
                onTap: () {
                  if (context.read<DetailMessageProvider>().showEmoji) {
                    context.read<DetailMessageProvider>().setShowEmoji(
                        !context.read<DetailMessageProvider>().showEmoji);
                  }
                },
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Type something...',
                    border: InputBorder.none),
              ),
            ),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.read<DetailMessageProvider>().setShowEmoji(
                    !context.read<DetailMessageProvider>().showEmoji);
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(
                Icons.emoji_emotions,
              ))
        ],
      ),
    );
  }

  Widget selectedImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.file(context.watch<DetailMessageProvider>().image!,
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 0,
          child: InkWell(
              onTap: () {
                context.read<DetailMessageProvider>().setImageNull();
              },
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                  ),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.white,
                  ))),
        )
      ],
    );
  }

  Widget _Image(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url), // Đường dẫn tới ảnh
            fit: BoxFit.cover, // Cách ảnh sẽ được hiển thị trong Container
          ),
        ),
      ),
    );
  }
}
