import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.avatarUrl,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 140,
            height: 140,
            margin: EdgeInsets.all(10),
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
          right: MediaQuery.of(context).size.width / 3.9,
          child: Container(
            width: 45,
            height: 45,
            decoration:  BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                color: Colors.grey.shade200,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ]
            ),
            child: Icon(
              Icons.edit,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}