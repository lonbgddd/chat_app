import 'package:flutter/material.dart';

class InforRow extends StatelessWidget {
  const InforRow({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1.0, color: const Color(0XFFC6C6C6))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          content,
          style: const TextStyle(color: Color(0XFF8E8E8E), fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
      ]),
    );
  }
}