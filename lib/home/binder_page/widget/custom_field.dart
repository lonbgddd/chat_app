import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Có viết tiểu sử"),
            Text("data")
          ],
        ),
      ),
    );
  }
}
