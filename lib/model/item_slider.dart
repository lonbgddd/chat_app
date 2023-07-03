import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:flutter/material.dart';

class ItemSlider {
  final Color color;
  final String image, title, subTitle;
  final int id;

  ItemSlider(
      {required this.color,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.id});
}

List<ItemSlider> sliderList = [
  ItemSlider(
      color: Colors.black,
      image: AppAssets.iconTinderPlatinum,
      title: 'Nâng cấp lên Binder Platinum',
      subTitle: 'Nâng cấp mọi hoạt động của bạn trên Binder',
      id: 1),
  ItemSlider(
    color: Color.fromRGBO(131,103,13, 100),
    image: AppAssets.iconTinderGold,
    title: 'Mua Binder Gold™',
    subTitle: 'Xem ai Thích bạn & nhiều tính năng khác!',
    id: 2),
  ItemSlider(
      color: Color.fromRGBO(242,73,86, 100),
      image: AppAssets.iconTinder,
      title: 'Mua Binder Plus®',
      subTitle: 'Nhận vô hạn lượt Thích, Hộ Chiếu & hơn thế nữa!',
      id: 3),

];
