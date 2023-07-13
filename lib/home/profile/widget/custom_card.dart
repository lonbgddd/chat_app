import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isIcon;

  const CustomCard({
    Key? key,
    this.icon,
    required this.title,
    this.subtitle,
     this.iconColor,
    required this.onTap,
    required this.isIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            width: 110,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isIcon ? Icon(icon, size: 25, color: iconColor,)
                    : SvgPicture.asset(AppAssets.iconTinder, width: 25),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    textAlign: TextAlign.center,
                    title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  subtitle ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: -5,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white54,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
