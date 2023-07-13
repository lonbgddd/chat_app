import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

List<ItemSlider> sliderList (BuildContext context){
  final appLocal = AppLocalizations.of(context);
  return [
    ItemSlider(
        color: Colors.black,
        image: AppAssets.iconTinderPlatinum,
        title: appLocal.sliderItemTitle1,
        subTitle: appLocal.sliderItemSubTitle1,
        id: 1),
    ItemSlider(
        color: Color.fromRGBO(131,103,13, 100),
        image: AppAssets.iconTinderGold,
        title: appLocal.sliderItemTitle2,
        subTitle: appLocal.sliderItemSubTitle2,
        id: 2),
    ItemSlider(
        color: Color.fromRGBO(242,73,86, 100),
        image: AppAssets.iconTinder,
        title: appLocal.sliderItemTitle3,
        subTitle: appLocal.sliderItemSubTitle3,
        id: 3),

  ];

}
