import 'package:chat_app/config/changedNotify/detail_message.dart';
import 'package:chat_app/features/message/data/models/user_time_model.dart';
import 'package:chat_app/features/message/domain/entities/chat_room_entity.dart';
import 'package:chat_app/features/message/presentation/bloc/detail_message/detail_message_bloc.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../config/helpers/helpers_database.dart';
import '../../domain/entities/chat_message_entity.dart';

class DetailMessage extends StatefulWidget {
  const DetailMessage(
      {super.key,
      this.uid,
      this.chatRoomId,
      this.name,
      this.avatar,
      this.token});

  final String? uid;
  final String? chatRoomId;
  final String? name;
  final String? avatar;
  final String? token;

  @override
  State<DetailMessage> createState() => _DetailMessageState();
}

class _DetailMessageState extends State<DetailMessage> {
  final TextEditingController messageController = TextEditingController();
  String keyUid ='';
  Future<void> getKeyUid() async {
    keyUid = await HelpersFunctions().getUserIdUserSharedPreference() as String;
  }

  // Stream<List<ChatMessageEntity>>? messages;

  @override
  Widget build(BuildContext context) {
    getKeyUid();
    return BlocConsumer<DetailMessageBloc, DetailMessageState>(
      listener: (context, state) {
        // if (state is MessageListLoaded) {
        //   setState(() {
        //     messages = state.messagesList;
        //   });
        // }
        if (state is EmojiPickerShow) {
          print("Show emoji picker");
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36))),
            child: Builder(builder: (context) {
              return Column(
                children: [
                  head(),
                  today(),
                  // messages != null
                  state is MessageListLoaded
                      ? Expanded(child: listMessage(state.messagesList,state.chatRoom))
                      : const CircularProgressIndicator(),
                  controlMessage(context),
                  if (state is ShowEmojiPicker) emoji(context)
                ],
              );
            }),
          ),
        );
      },
    );
  }

  Widget head() {
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

  Widget today() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // Căn giữa theo chiều ngang
        children: const [
          Expanded(
            child: Divider(color: Colors.black), // Đường viền
          ),
        ]);
  }


  Widget listMessage(Stream<List<ChatMessageEntity>> messageListStream,Stream<ChatRoomEntity> chatRoom) {
    DateFormat timeFormat = DateFormat('HH:mm a');
    DateFormat dateFormat = DateFormat('MMM dd, HH:mm');
    String userTime ='';
    bool checkTime(DateTime dateTime) {
      DateTime timeCurrent = DateTime.now();
      String date = DateFormat('yyyy-MM-dd').format(dateTime);
      String dateCurrent = DateFormat('yyyy-MM-dd').format(timeCurrent);
      if (date == dateCurrent) {
        return true;
      }
      return false;
    }

    bool checkDuration(DateTime dateTime1, DateTime dateTime2) {
      if (dateTime1.difference(dateTime2).inMinutes > 5) {
        return true;
      }
      return false;
    }
    return StreamBuilder(
        stream: chatRoom,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userTimes = snapshot.data?.userTimes as List<dynamic>;
            for (var index in userTimes) {
              if (index.uid == widget.uid) {
                userTime = index.time!.toString();
              }
            }
          }
          return StreamBuilder(
              stream: messageListStream,
              builder: (context, snapshot) {
                BlocProvider.of<DetailMessageBloc>(context)
                    .add(CompareUserTime(keyUid!, widget.chatRoomId!));
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data?.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 10),
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          DateTime time = DateTime.parse(
                              snapshot.data?[index].time.toString() ?? "");
                          // return BlocConsumer<DetailMessageBloc, DetailMessageState>(
                          //   listenWhen: (previous, current) => current is ChatItemActionState,
                          //   buildWhen: (previous, current) => current is! ChatItemActionState,
                          //   listener: (context, state) {},
                          //     builder: (context, state) {
                          //
                          //      return
                          //
                            return Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  if (checkTime(time))
                                    Column(children: [
                                      if (index != snapshot.data!.length - 1 && checkDuration(time, DateTime.parse(snapshot.data?[index + 1].time.toString() ?? '')))
                                        dateTimeFormat(timeFormat, time)
                                      else if (index == snapshot.data!.length - 1)
                                        dateTimeFormat(timeFormat, time)
                                      else if (context.watch<DetailMessageProvider>().detailTime == time.toString())
                                        dateTimeFormat(timeFormat, time)
                                    ])
                                  else
                                    Column(
                                      children: [
                                        if (index != snapshot.data!.length - 1 && checkDuration(time, DateTime.parse(snapshot.data?[index + 1].time.toString() ?? '')))
                                          dateTimeFormat(dateFormat, time)
                                        else if (index == snapshot.data!.length - 1)
                                          dateTimeFormat(dateFormat, time)
                                        else if (context.watch<DetailMessageProvider>().detailTime == time.toString())
                                          dateTimeFormat(dateFormat, time)
                                      ],
                                    ),
                                  Align(
                                    alignment:
                                        (snapshot.data?[index].uid != widget.uid ? Alignment.topLeft : Alignment.topRight),
                                    child: Column(
                                      crossAxisAlignment:
                                          snapshot.data?[index].uid == widget.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if(context.read<DetailMessageProvider>().detailTime == ''){
                                              context.read<DetailMessageProvider>().setDetailTime(time.toString());
                                            }else{
                                              context.read<DetailMessageProvider>().setDetailTime('');
                                            }
                                          },
                                          child: Container(
                                            width: snapshot.data![index].messageText.toString().length > 20 ? MediaQuery.of(context).size.width / 2 : null,
                                            decoration: BoxDecoration(
                                              borderRadius: snapshot.data?[index].imageURL != '' ? const BorderRadius.all(Radius.circular(10))
                                                  : snapshot.data?[index].uid ==
                                                          widget.uid
                                                      ? const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(10),
                                                          topRight:
                                                              Radius.circular(10),
                                                          bottomLeft:
                                                              Radius.circular(10))
                                                      : const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(10),
                                                          topRight:
                                                              Radius.circular(10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                              color: (snapshot.data![index].uid != widget.uid
                                                  ? const Color.fromARGB(255, 248, 222, 225)
                                                  : Colors.grey.shade300),
                                            ),
                                            padding:
                                                snapshot.data?[index].imageURL != ''
                                                    ? EdgeInsets.zero
                                                    : const EdgeInsets.all(16),
                                            child:
                                                snapshot.data![index].imageURL != ''
                                                    ? image(snapshot.data![index].imageURL!, context)
                                                    : Text(snapshot.data?[index].messageText ?? '', style: const TextStyle(fontSize: 15)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (userTime.isNotEmpty)
                                    (time.compareTo(DateTime.parse(userTime)) > 0)
                                        ? Container()
                                        : DateTime.parse(userTime) == time
                                            ? Align(alignment: Alignment.bottomRight, child: avatarMini())
                                            : Container()
                                ],
                              ),
                            );
                        })


                    : Container();
               });
        });
  }

  Widget emoji(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: MediaQuery.of(context).size.height * 0.3,
      child: EmojiPicker(
        textEditingController: messageController,
        onBackspacePressed: () {},
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

  Widget controlMessage(BuildContext context) {
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
                    textFieldEmoji(context),
                    Container(),
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {},
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
                  if (messageController.text.isNotEmpty) {
                    BlocProvider.of<DetailMessageBloc>(context).add(AddMessage(
                        widget.uid!,
                        widget.chatRoomId!,
                        messageController.text,
                        "",
                        widget.token!));
                    messageController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldEmoji(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: TextField(
                controller: messageController,
                keyboardType: TextInputType.multiline,
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
                // BlocProvider.of<DetailMessageBloc>(context)
                //     .add(const ShowEmojiPicker());
              },
              icon: const Icon(
                Icons.emoji_emotions,
              ))
        ],
      ),
    );
  }

  Widget dateTimeFormat(DateFormat dateFormat, DateTime time) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        dateFormat.format(time),
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget selectedImage(BuildContext context) {
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

  Widget image(String url, BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('image-message', queryParameters: {
          'url': url,
        });
      },
      child: ClipRRect(
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
      ),
    );
  }

  // Widget image(String url) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: Container(
  //       width: 150,
  //       height: 200,
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: NetworkImage(url), // Đường dẫn tới ảnh
  //           fit: BoxFit.cover, // Cách ảnh sẽ được hiển thị trong Container
  //         ),
  //       ),
  //     ),
  //   );
  // }



  Widget avatarMini() {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      child: CircleAvatar(
        radius: 8,
        backgroundImage: NetworkImage(widget.avatar.toString()),
      ),
    );
  }

}
