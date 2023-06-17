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
                borderRadius: BorderRadius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/$image'),
              const SizedBox(width: 10,),
              Text(
                text ?? "null",
                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }
}
