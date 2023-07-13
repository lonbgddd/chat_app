import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/profile/widget/item_slider.dart';
import 'package:chat_app/model/item_slider.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SliderCustom extends StatefulWidget {
  const SliderCustom({Key? key}) : super(key: key);

  @override
  State<SliderCustom> createState() => _SliderCustomState();
}

class _SliderCustomState extends State<SliderCustom> {
  final _carouseController = CarouselController();
  int currentIndex = 0;

  void _showBottomModal({
    required BuildContext context,
    required Color color,
    Color? iconColor,
    bool? isHaveColor,
    bool? isHaveIcon,
    bool? isSuperLike,
    IconData? iconData,
    String? assetsBanner,
    String? assetsIcon,
    List<PackageModel>? packageModel,
    required String subTitle,
    required String title,
  }) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    EdgeInsets padding = mediaQueryData.padding;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: padding.top),
          height: MediaQuery.of(context).size.height,
          child: BottomModalFullScreen(
            packageModel: packageModel,
            color: color,
            assetsBanner: assetsBanner,
            assetsIcon: assetsIcon,
            title: title,
            subTitle: subTitle,
            iconColor: iconColor,
            isHaveColor: isHaveColor ?? false,
            isHaveIcon: isHaveIcon ?? false,
            iconData: iconData,
            isSuperLike: isSuperLike ?? false,
          ),
        );
      },
    );
  }

  void checkPackage({required int index, required BuildContext context}) {
    switch (index) {
      case 1:
        _showBottomModal(
          context: context,
          color: Colors.white,
          title: "Binder",
          isHaveIcon: false,
          packageModel: packageBinderGoldList(context),
          assetsBanner: AppAssets.iconTinderPlatinumBanner,
          assetsIcon: AppAssets.iconTinderPlatinum,
          isHaveColor: true,
          subTitle: AppLocalizations.of(context).sliderCustomSubTitle1,
        );
        break;
      case 2:
        _showBottomModal(
          context: context,
          color: Colors.yellow,
          title: "Binder",
          isHaveIcon: false,
          packageModel: packageBinderGoldList(context),
          assetsBanner: AppAssets.iconTinderGoldBanner,
          assetsIcon: AppAssets.iconTinderGold,
          isHaveColor: true,
          subTitle: AppLocalizations.of(context).sliderCustomSubTitle2,
        );
        break;
      case 3:
        _showBottomModal(
          context: context,
          color: Colors.red.shade200,
          title: "Binder",
          isHaveIcon: false,
          packageModel: packageBinderGoldList(context),
          assetsBanner: AppAssets.iconTinderPlusBanner,
          assetsIcon: AppAssets.iconTinder,
          isHaveColor: true,
          subTitle: AppLocalizations.of(context).sliderCustomSubTitle3,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {},
              child: CarouselSlider(
                carouselController: _carouseController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: sliderList(context)
                    .map((item) => ItemSliderCustom(itemSlider: item))
                    .toList(),
              ),
            ),
            Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                top: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: sliderList(context).asMap().entries.map((e) {
                    return GestureDetector(
                      child: Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == e.key
                                ? Colors.black
                                : Colors.grey),
                      ),
                    );
                  }).toList(),
                )),
          ],
        ),
        ElevatedButton(
            onPressed: () => checkPackage(
                index: sliderList(context)[currentIndex].id, context: context),
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                fixedSize: Size(250, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: Text(
              sliderList(context)[currentIndex].id == 1
                  ? AppLocalizations.of(context).sliderCustomSubTitle4
                  : sliderList(context)[currentIndex].title,
              style: TextStyle(color: sliderList(context)[currentIndex].color),
            )),
      ],
    );
  }
}
