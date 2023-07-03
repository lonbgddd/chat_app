import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/changedNotify/confirm_profile_watch.dart';
import '../../../config/helpers/app_assets.dart';
import 'package:flutter_svg/svg.dart';

import '../../widget/button_submit_page_view.dart';


class RulersPageSection extends StatelessWidget {
  const RulersPageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageDataConfirmProfileProvider>(context);

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => pageProvider.showCustomDialog(context),
                    icon: SvgPicture.asset(
                      AppAssets.iconDelete,
                      width: 25,
                      height: 25,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SvgPicture.asset(
                    AppAssets.iconTinder,
                    width: 45,
                    height: 45,
                    fit: BoxFit.contain,

                  ),
                  const SizedBox(height: 10,),
                  const Text('Chào mừng đến với Binder.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Vui lòng tuân thủ các Quy tắc chung này.',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),

                  const SizedBox(height: 30,),
                  const Text('Hãy là chính bạn.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text('Đảm bảo ảnh, độ tuổi và tiểu sử của bạn đều là thật.',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Đảm bảo an toàn.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  RichText(
                    textAlign: TextAlign.start,
                    text:TextSpan(
                      text: 'Đừng vội vàng chia sẻ thông tin cá nhân. ',
                      style: TextStyle(color: Colors.black,fontSize: 14, ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Hẹn hò an toàn.',
                          style: TextStyle(decoration: TextDecoration.underline,color: Colors.blue),
                        ),
                      ],

                    ),
                  ),

                  const SizedBox(height: 20,),
                  const Text('Cư xử chuẩn mực.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text('Tôn trọng người khác và đối xử với họ như cách bạn muốn mọi người thể hiện với bạn.',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text('Hãy luôn chủ động.',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Text('Luôn báo cáo hành vi xấu.',
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            ButtonSubmitPageView(text: 'Tiếp theo',marginBottom: 70, color: Colors.transparent, onPressed: () => pageProvider.nextPage(),),
          ],
        ),
      ),
    );
  }
}
