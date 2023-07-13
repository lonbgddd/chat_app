import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonNotification extends StatelessWidget {
  const ButtonNotification(
      {super.key,
      required this.title,
      required this.idUser,
      required this.router,
      this.chatRoomId,
      this.name,
      this.avatar});

  final String title;
  final String idUser;
  final String router;
  final String? chatRoomId;
  final String? name;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => title == 'match'
          ? context.goNamed(router, queryParameters: {
              'uid': idUser,
            })
          : context.goNamed(router, queryParameters: {
              'uid': idUser,
              'chatRoomId': chatRoomId,
              'name': name,
              'avatar': avatar,
            }),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            border: Border.all(width: 2, color: Colors.grey)),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
