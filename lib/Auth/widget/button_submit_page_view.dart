import 'package:flutter/material.dart';
class ButtonSubmitPageView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double marginBottom;
  final Color color;

  const ButtonSubmitPageView(
      {Key? key,
        required this.text,
        required this.marginBottom,
        required this.color,
        required this.onPressed,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: marginBottom,left: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [const Color.fromRGBO(234, 64, 128, 1), const Color.fromRGBO(238, 128, 95, 1)],
        ),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: color,
          ),
          child: Text(text, style: TextStyle(fontSize: 20, color:  Colors.white ,fontWeight: FontWeight.w600),)),
    );
  }
}
