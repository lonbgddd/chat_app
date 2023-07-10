import 'package:chat_app/home/profile/widget/custom_package_card.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomModalFullScreen extends StatelessWidget {
  final Color color;
  final Color? iconColor;
  final String title;
  final String subTitle;
  final bool isHaveColor;
  final bool isHaveIcon;
  final bool isSuperLike;
  final String? assetsBanner;
  final String? assetsIcon;
  final IconData? iconData;
  final List<PackageModel>? packageModel;

  const BottomModalFullScreen(
      {Key? key,
        required this.color,
        required this.title,
        required this.subTitle,
        required this.isHaveColor,
        this.assetsBanner,
        required this.isHaveIcon,
        this.iconData,
        this.iconColor,
        this.assetsIcon,
        this.packageModel,
        required this.isSuperLike})
      : super(key: key);

  @override
  Widget build(BuildContext context)

  {
    final height = MediaQuery.of(context).size.height;
    final styleTextSpan = TextStyle(color: Colors.black, fontSize: 13);
    return Container(
      decoration: isHaveColor
          ? BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color, Colors.white],
          stops: [0.01, 0.1],
        ),
      )
          : null,
      child:  Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: context.pop,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isHaveIcon
                    ? Icon(
                  iconData,
                  color: iconColor,
                )
                    : SvgPicture.asset(assetsIcon!, width: 24),
                SizedBox(width: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (!isHaveIcon)
                  SvgPicture.asset(
                    assetsBanner!,
                    width: 44,
                  ),
                SizedBox(width: 36),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: height / 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        subTitle,
                        style: TextStyle(
                            fontSize: 24,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Chọn một gói",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: double.parse('${height / 4.5}'),
                        // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: packageModel!.length,
                          itemBuilder: (context, index) {
                            final package = packageModel![index];
                            return CustomPackageCard(packageModel: package);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: double.parse('${height / 2}'),
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: Colors.grey, width: 0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Positioned(
                            top: -10,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.5),
                                  child: Text(
                                    "Đã bao gồm trong Binder",
                                    style: TextStyle(
                                        fontSize: 13, letterSpacing: 0.8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildRowTitle("Thích không giới hạn"),
                                buildRowTitle("5 lượt Siêu Thích mỗi tháng")
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    width: double.infinity,
                    height: height / 5.5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.8))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text:
                              "Khi nhấn Tiếp tục, bạn sẽ được tính phí, gói đăng ký của bạn sẽ được tự động gia hạn với cùng mức giá và thời lượng cho đến khi bạn huỷ bỏ, bất cứ lúc nào, thông qua phần cài đặt của Google Play, và bạn chấp thuận ",
                              style: styleTextSpan,
                              children: [
                                TextSpan(
                                  text: "Điều khoản",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),),
                                TextSpan(text: " của chúng tôi.")
                              ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: color,
                                fixedSize: Size(250, 50),
                                backgroundColor: color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            onPressed: () {},
                            child: Text(
                              "Tiếp tục",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget buildRowTitle(String title) {
    return Row(
      children: [
        Icon(
          Icons.check,
          size: 29,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
        )
      ],
    );
  }
}
