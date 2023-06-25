import 'package:flutter/material.dart';

class InterestItem extends StatelessWidget {
  const InterestItem({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color.fromRGBO(229, 58, 69, 100).withOpacity(0.4),
            const Color.fromRGBO(229, 58, 69, 100).withOpacity(0.8)
          ]),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}