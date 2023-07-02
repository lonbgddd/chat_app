import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 170,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red[300]!,
                  width: 4,
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: -8,
            child: Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.edit,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
