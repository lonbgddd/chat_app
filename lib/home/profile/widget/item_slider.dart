import 'package:chat_app/model/item_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemSliderCustom extends StatelessWidget {
  final ItemSlider itemSlider;

  const ItemSliderCustom({Key? key, required this.itemSlider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              itemSlider.image,
              width: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              itemSlider.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          itemSlider.subTitle,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
