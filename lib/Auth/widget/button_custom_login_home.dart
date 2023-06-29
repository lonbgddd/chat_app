import 'package:flutter/material.dart';
class ButtonCustom extends StatelessWidget {
  final String? text;
  final String? image;
  final VoidCallback? onPressed;
  final Color? color;

  const ButtonCustom(
      {Key? key,
        required this.text,
        this.image,
        required this.onPressed,
        this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(image!,width: 25,),
              const SizedBox(width: 10,),
              Text(
                text ?? "null",
                style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.black, fontSize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }
}
