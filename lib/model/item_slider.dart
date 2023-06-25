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
      title: 'Upgrade to Binder Platinum',
      subTitle: 'Level up every action you take on Binder',
      id: 1),
  ItemSlider(
    color: Color.fromRGBO(131,103,13, 100),
    image: AppAssets.iconTinderGold,
    title: 'Get Binder Gold™',
    subTitle: 'See Who Likes You & More',
    id: 2),
  ItemSlider(
      color: Color.fromRGBO(242,73,86, 100),
      image: AppAssets.iconTinder,
      title: 'Get Binder Plus®',
      subTitle: 'Get Unlimited Likes, Passport & more!',
      id: 3),

];
