import 'package:chat_app/home/profile/components/slider.dart';
import 'package:chat_app/home/profile/widget/bottom_modal.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/profile/widget/custom_card.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';

class BodyBuyPremium extends StatefulWidget {
  const BodyBuyPremium({Key? key}) : super(key: key);

  @override
  State<BodyBuyPremium> createState() => _BodyBuyPremiumState();
}

class _BodyBuyPremiumState extends State<BodyBuyPremium> {
  void _showModal() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => BottomModal());
  }

  void _showBottomModal(
      {required Color color,
      Color? iconColor,
      bool? isHaveColor,
      required bool isHaveIcon,
      bool? isSuperLike,
      List<PackageModel>? packageModel,
      IconData? iconData,
      required BuildContext context,
      required String subTitle,
      required String title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);
        EdgeInsets padding = mediaQueryData.padding;

        return Container(
          padding: EdgeInsets.only(top: padding.top),
          height: MediaQuery.of(context).size.height,
          child: BottomModalFullScreen(
            color: color,
            title: title,
            subTitle: subTitle,
            packageModel: packageModel,
            iconColor: iconColor,
            isHaveColor: isHaveColor ?? false,
            isHaveIcon: isHaveIcon,
            iconData: iconData,
            isSuperLike: isSuperLike ?? false,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 50),
      color: Colors.grey[100],
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  onTap: () => _showBottomModal(
                      context: context,
                      packageModel: packageBinderSuperLike,
                      isSuperLike: true,
                      isHaveColor: true,
                      iconData: Icons.star,
                      isHaveIcon: true,
                      iconColor: Colors.blue,
                      color: Colors.blue[200]!,
                      title: 'Nhận lượt Siêu Thích',
                      subTitle:
                          "Siêu Thích giúp bạn nổi bật. Tăng khả năng được tương hợp gấp 3 lần!"),
                  iconColor: Colors.blue,
                  icon: Icons.star,
                  title: '0 lượt Siêu Thích',
                  subtitle: "MUA THÊM",
                  isIcon: true,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  isIcon: true,
                  onTap: _showModal,
                  iconColor: Colors.purple,
                  icon: Icons.bolt,
                  title: 'Lượt Tăng Tốc của tôi',
                  subtitle: "MUA THÊM",
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  isIcon: false,
                  onTap: () {},
                  title: "Gói đăng ký",
                ),
              ),
            ],
          ),
          const SliderCustom(),
        ],
      ),
    );
  }
}
