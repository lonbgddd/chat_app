import 'package:chat_app/home/profile/widget/bottom_modal.dart';
import 'package:chat_app/home/profile/components/slider.dart';

import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/profile/widget/custom_card.dart';
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

//         return Container(
//           height: MediaQuery.of(context).size.height / 2.5,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(30),
//               topLeft: Radius.circular(30),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 5.5,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     child: const Divider(
//                       thickness: 3.5,
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.grey,
//                       size: 26,
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "My boosts",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       const Text(
//                         "Be a top profile in your area for 30 minutes to\nget more matches.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 16),
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.bolt,
//                         color: Colors.purple,
//                         size: 38,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Boosts",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 18),
//                           ),
//                           Text(
//                             "0 left",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     shadowColor: Colors.grey,
//                     fixedSize: const Size(250, 50),
//                     backgroundColor: Colors.purple[400],
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: const Text(
//                     "Get More Boosts",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
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
