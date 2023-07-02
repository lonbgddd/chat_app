import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomModalFullScreen extends StatelessWidget {
  final double height;
  final Color color;
  final String title;
  final String? subTitle;
  final bool isHaveColor;

  const BottomModalFullScreen(
      {Key? key,
      required this.height,
      required this.color,
      required this.title,
      this.subTitle,
      required this.isHaveColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isHaveColor
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color, Colors.white],
                stops: [0.02, 0.08],
              ),
            )
          : null,
      child: Padding(
        padding: EdgeInsets.only(top: height / 80),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: context.pop,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.blue,
                  size: 22,
                ),
                SizedBox(width: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 36),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  subTitle ?? '',
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Select a package",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
