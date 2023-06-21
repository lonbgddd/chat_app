import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(avatarUrl), fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Center(
                  child: Icon(
                Icons.edit,
                color: Color.fromRGBO(229, 58, 69, 100),
                size: 16,
              )),
            ),
          )
        ],
      ),
    );
  }
}
