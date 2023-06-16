import 'package:chat_app/model/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/changedNotify/chat_item_notify.dart';
import '../model/model.dart';

class ChatRoomsTile extends StatelessWidget {
  String? uid;
  String? chatRoomId;
  ChatMessage? mess;
  ChatRoomsTile({super.key, this.uid, this.chatRoomId});

  Future<User?> getUser(context) async {
    lassMess(context);
    User user = await Provider.of<ItemChatNotify>(context)
        .getUserInformation(uid, chatRoomId ?? "");
    return user;
  }

  lassMess(context) async {
    mess =
        await Provider.of<ItemChatNotify>(context).getLastMessage(chatRoomId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUser(context),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        return GestureDetector(
          onTap: () => context.goNamed('Home-detail', queryParameters: {
            'uid': uid.toString(),
            'chatRomId': chatRoomId.toString(),
            'name': snapshot.data?.fullName,
            'avatar': snapshot.data?.avatar
          }),
          child: Container(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data?.avatar ?? ""),
                        maxRadius: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data?.fullName ?? "",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "${mess?.messageText} ${mess?.time.hour}:${mess?.time.minute}",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade600,
                                    fontWeight: true
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
