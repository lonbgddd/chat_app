import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/chat_item_notify.dart';
import '../../model/chat_user.dart';
import '../../model/user_model.dart';
import 'detail_Message.dart';

class ItemMessage extends StatefulWidget {
  String? uid;
  String? chatRoomId;
  ChatMessage? mess;

  ItemMessage({super.key, this.uid, this.chatRoomId});

  @override
  State<StatefulWidget> createState() {
    return ItemMessageState();
  }
}

class ItemMessageState extends State<ItemMessage> {
  ChatMessage? mess;

  @override
  Widget build(BuildContext context) {
    lassMess(context) async {
      mess = await Provider.of<ItemChatNotify>(context)
          .getLastMessage(widget.chatRoomId!);
    }

    Future<UserModal?> getUser(context) async {
      lassMess(context);
      UserModal user = await Provider.of<ItemChatNotify>(context)
          .getUserInformation(widget.uid, widget.chatRoomId ?? "");
      return user;
    }

    @override
    Widget build(BuildContext context) {
      return FutureBuilder(
        future: getUser(context),
        builder: (context, AsyncSnapshot<UserModal?> snapshot) {
          return snapshot.hasData
              ? GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.95,
                        child: DetailMessage(
                          uid: widget.uid,
                          chatRoomId: widget.chatRoomId,
                          name: snapshot.data?.fullName,
                          avatar: snapshot.data?.avatar,
                          token: snapshot.data?.token,
                        ));
                  });
            },
            child: Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(left: 20, bottom: 20),
              width: 60,
              height: 60,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          snapshot.data?.avatar ?? ""),
                      child: snapshot.data!.activeStatus == "online"
                          ? Stack(children: const [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 11,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ])
                          : null,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  snapshot.data?.fullName ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  mess?.messageText ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          Text(
                            mess != null
                                ? DateFormat('HH:mm a').format(mess!.time)
                                : '',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ) : Container();
        },
      );
    }

    return FutureBuilder(
      future: getUser(context),
      builder: (context, AsyncSnapshot<UserModal?> snapshot) {
        return snapshot.hasData
            ? GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.95,
                            child: DetailMessage(
                              uid: widget.uid,
                              chatRoomId: widget.chatRoomId,
                              name: snapshot.data?.fullName,
                              avatar: snapshot.data?.avatar,
                              token: snapshot.data?.token,
                            ));
                      });
                },
                child: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(left: 20, bottom: 20),
                  width: 60,
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(snapshot.data?.avatar ?? ""),
                          child: snapshot.data!.activeStatus == "online"
                              ? Stack(children: const [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      radius: 11,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ])
                              : null,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 20),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data?.fullName ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      mess?.messageText ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                mess != null
                                    ? DateFormat('HH:mm a').format(mess!.time)
                                    : '',
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
