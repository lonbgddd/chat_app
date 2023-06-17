import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../config/changedNotify/chat_item_notify.dart';
import '../../model/chat_user.dart';
import '../../model/model.dart';
import 'detail_message.dart';

class itemMessage extends StatefulWidget {
  String? uid;
  String? chatRoomId;
  ChatMessage? mess;

  itemMessage({super.key, this.uid, this.chatRoomId});

  @override
  State<StatefulWidget> createState() {
    return itemMessageState();
  }
}

class itemMessageState extends State<itemMessage> {
  ChatMessage? mess;
  ChatMessage? mess2;

  @override
  Widget build(BuildContext context) {
    lassMess(context) async {
      mess = await Provider.of<ItemChatNotify>(context)
          .getLastMessage(widget.chatRoomId!);
      setState(() {
        mess2 = mess;
      });
    }

    Future<User?> getUser(context) async {
      lassMess(context);
      User user = await Provider.of<ItemChatNotify>(context)
          .getUserInformation(widget.uid, widget.chatRoomId ?? "");
      return user;
    }

    return FutureBuilder(
      future: getUser(context),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: DetailMessage(
                          uid: widget.uid,
                          chatRoomId: widget.chatRoomId,
                          name: snapshot.data?.name,
                          avatar: snapshot.data?.avatar));
                });
          },
          child: Container(
            color: Colors.white,
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
                    backgroundImage: NetworkImage(snapshot.data?.avatar ?? ""),
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data?.name ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              mess2?.messageText ?? '',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                        const Spacer(),
                        Text(
                          mess2 != null ? DateFormat('HH:mm a').format(mess2!.time) : '',
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}