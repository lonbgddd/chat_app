import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardSettingCustom extends StatelessWidget {
  final String? assetsIcon;
  final String? assetsBanner;
  final String subTitle;
  final String? title;
  final double width;
  final bool? isHaveIcon;
  final IconData? iconData;
  final Function() onTap;
  final Color? iconColor;

  const CardSettingCustom(
      {super.key,
      this.assetsIcon,
      this.assetsBanner,
      required this.subTitle,
      required this.onTap,
      required this.width,
      this.isHaveIcon,
      this.iconData,
      this.iconColor,
      this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 5,left: 10,right: 10),
      child: GestureDetector(

        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          width: width,
          height: double.tryParse('${size.height / 9}'),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isHaveIcon!
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                    spreadRadius: 0.5,
                                    offset: Offset(0, 0.5),
                                  ),
                                ],
                              ),
                              width: 40,
                              height: 40,
                              child: Icon(
                                iconData,
                                color: iconColor,
                              ),
                            )
                          : SvgPicture.asset(assetsIcon!, width: 24),
                      SizedBox(
                        width: 4,
                      ),
                      if (title == null)
                        Text(
                          "Binder",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      SizedBox(
                        width: 2,
                      ),
                      if (!isHaveIcon!)
                        SvgPicture.asset(
                          assetsBanner!,
                          width: 64,
                          height: 20,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: isHaveIcon!?iconColor:Colors.grey.shade900),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
