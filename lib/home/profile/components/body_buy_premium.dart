import 'package:chat_app/home/profile/widget/bottom_modal.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/profile/widget/custom_card.dart';
import 'package:chat_app/home/profile/components/slider.dart';
import 'package:flutter/material.dart';

class BodyBuyPremium extends StatefulWidget {
  const BodyBuyPremium({Key? key}) : super(key: key);

  @override
  State<BodyBuyPremium> createState() => _BodyBuyPremiumState();
}

class _BodyBuyPremiumState extends State<BodyBuyPremium> {
  void showModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BottomModal();
      },
    );
  }

  void _showBottomModal(
      {required Color color,
      bool? isHaveColor,
      String? subTitle,
      required String title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        double height = MediaQuery.of(context).size.height;
        return BottomModalFullScreen(
          color: color,
          height: height,
          title: title,
          subTitle: subTitle,
          isHaveColor: isHaveColor ?? false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
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
                        isHaveColor: true,
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
                    onTap: showModal,
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
                    onTap: () => _showBottomModal(
                        color: Colors.red[200]!, title: 'My Subscriptions'),
                    title: "Gói đăng ký",
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SliderCustom(),
          ],
        ),
      ),
    );
  }
}
