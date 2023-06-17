import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/data_mothes.dart';
import '../../model/chat_user.dart';

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
  bool _showEmoji = false;
  final messageController = TextEditingController();
  Stream<QuerySnapshot>? chats;
  String? uid = '';
  String? name = '';

  addMessage() {
    if (messageController.text.isNotEmpty) {
      DatabaseMethods().addMessage(
          widget.chatRoomId ?? "",
          ChatMessage(
              uid: widget.uid ?? "",
              messageText: messageController.text,
              imageURL: '',
              time: DateTime.now()),
          widget.token ?? "");

      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    DatabaseMethods().getChats(widget.chatRoomId ?? "").then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    uid = widget.uid;
    name = widget.name;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36), topRight: Radius.circular(36))),
        child: Stack(
          children: [
            Head(),
            // Today(),
            ListMessage(),
            ControllMessage(),
            if (_showEmoji) Emoji()
          ],
        ),
      ),
    );
  }

  Widget Head() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(widget.avatar.toString()),
          ),
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const TextSpan(
              text: '\nOnline',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ))
        ])),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            onPressed: () {
              // context.read<indexProvider>().clickCheck();
            },
            icon: const Icon(Icons.menu_rounded),
          ),
        )
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            // Khoảng cách giữa viền và văn bản
            child: Text('Today'),
          ),
          Expanded(
            child: Divider(color: Colors.black), // Đường viền
          ),
        ]);
  }

  // void checkTime(DateTime dateTime) {
  //   var formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  //   if () {}
  // }

  Widget ListMessage() {
    return Padding(
      padding: const EdgeInsets.only(top: 90, bottom: 50),
      child: StreamBuilder(
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
                    return Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (snapshot.data?.docs[index]['uid'] != uid
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Column(
                          crossAxisAlignment:
                              snapshot.data?.docs[index]['uid'] == uid
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: snapshot.data!.docs[index]['messageText']
                                          .toString()
                                          .length >
                                      20
                                  ? MediaQuery.of(context).size.width / 2
                                  : null,
                              decoration: BoxDecoration(
                                borderRadius:
                                    snapshot.data?.docs[index]['uid'] == uid
                                        ? const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                color: (snapshot.data?.docs[index]['uid'] != uid
                                    ? const Color.fromARGB(255, 248, 222, 225)
                                    : Colors.grey.shade300),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                snapshot.data?.docs[index]['messageText'],
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            Text(
                              DateFormat('HH:mm a').format(DateTime.parse(
                                  snapshot.data?.docs[index]['time'])),
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Text('hehe');
        },
      ),
    );
  }

  Widget Emoji() {
    return Container(
        // height: MediaQuery.of(context).size.height * 0.3,
        // child: EmojiPicker(
        //   textEditingController: messageController,
        //   onBackspacePressed: () {
        //     // Do something when the user taps the backspace button (optional)
        //     // Set it to null to hide the Backspace-Button
        //   },
        //   //textEditingController: textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        //   config: Config(
        //     columns: 7,
        //     bgColor: Colors.white,
        //     emojiSizeMax: 32 *
        //         (foundation.defaultTargetPlatform == TargetPlatform.iOS
        //             ? 1.30
        //             : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
        //   ),
        // ),
        );
  }

  Widget ControllMessage() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16, bottom: 10),
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onTap: () {
                        if (_showEmoji) {
                          setState(() {
                            _showEmoji = !_showEmoji;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Type something...',
                          border: InputBorder.none),
                    )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _showEmoji = !_showEmoji;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
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
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    addMessage();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
