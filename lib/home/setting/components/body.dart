import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/compnents/body_discovery_setting.dart';
import 'package:chat_app/home/binder_page/compnents/body_high_search.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/setting/widget/card_custom.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardSettingCustom(
              onTap: () {
                _showBottomModal(
                  context: context,
                  color: Colors.white,
                  title: "Binder",
                  isHaveIcon: false,
                  packageModel: packageBinderGoldList,
                  assetsBanner: AppAssets.iconTinderPlatinumBanner,
                  assetsIcon: AppAssets.iconTinderPlatinum,
                  isHaveColor: true,
                  subTitle:
                      'Nâng cấp lượt Thích và Siêu Thích của bạn với gói Platinum.',
                );
              },
              assetsIcon: AppAssets.iconTinderPlatinum,
              assetsBanner: AppAssets.iconTinderPlatinumBanner,
              subTitle:
                  'Lượt Thích được ưu tiên, Xem ai Thích bạn & Nhiều quyền lợi khác',
              width: size.width / 1,
              isHaveIcon: false),
          CardSettingCustom(
              onTap: () {
                _showBottomModal(
                  context: context,
                  color: Colors.yellow,
                  title: "Binder",
                  isHaveIcon: false,
                  packageModel: packageBinderGoldList,
                  assetsBanner: AppAssets.iconTinderGoldBanner,
                  assetsIcon: AppAssets.iconTinderGold,
                  isHaveColor: true,
                  subTitle:
                      'Xem ai thích bạn và tương hợp ngay lập tức với Binder Gold™.',
                );
              },
              assetsIcon: AppAssets.iconTinderGold,
              assetsBanner: AppAssets.iconTinderGoldBanner,
              subTitle: 'Xem ai Thích bạn & nhiều tính năng khác!',
              width: size.width / 1,
              isHaveIcon: false),
          CardSettingCustom(
            onTap: () {
              _showBottomModal(
                context: context,
                color: Colors.red.shade200,
                title: "Binder",
                isHaveIcon: false,
                packageModel: packageBinderGoldList,
                assetsBanner: AppAssets.iconTinderPlusBanner,
                assetsIcon: AppAssets.iconTinder,
                isHaveColor: true,
                subTitle:
                    'Lượt Thích vô hạn. Lượt Quay Lại vô hạn. Hộ Chiếu vô hạn. Không có quảng cáo.',
              );
            },
            assetsIcon: AppAssets.iconTinder,
            assetsBanner: AppAssets.iconTinderPlusBanner,
            subTitle: 'Lượt Thích Vô Hạn & Nhiều quyền lợi khác!',
            width: size.width / 1,
            isHaveIcon: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardSettingCustom(
                onTap: () {
                  _showBottomModal(
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
                          "Siêu Thích giúp bạn nổi bật. Tăng khả năng được tương hợp gấp 3 lần!");
                },
                subTitle: 'Nhận lượt Siêu Thích',
                isHaveIcon: true,
                iconData: Icons.star,
                iconColor: Colors.blue,
                width: size.width / 2.3,
                title: '',
              ),
              CardSettingCustom(
                onTap: () => context.goNamed('home-highlight-page'),
                subTitle: 'Mua lượt Tăng Tốc',
                isHaveIcon: true,
                iconData: Icons.bolt,
                iconColor: Colors.purple,
                width: size.width / 2.3,
                title: '',
              ),
            ],
          ),
          CardSettingCustom(
            subTitle: 'Dùng chế độ ẩn danh',
            title: '',
            isHaveIcon: true,
            iconData: Icons.visibility_off_outlined,
            onTap: () {
              _showBottomModal(
                context: context,
                color: Colors.red.shade200,
                title: "Binder",
                isHaveIcon: false,
                packageModel: packageBinderGoldList,
                assetsBanner: AppAssets.iconTinderPlusBanner,
                assetsIcon: AppAssets.iconTinder,
                isHaveColor: true,
                subTitle: 'Chỉ hiển thị hồ sơ với những người mà bạn đã thích.',
              );
            },
            width: size.width / 1,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "TÌM KIẾM",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BodyDiscoverySetting(),
          SizedBox(
            height: 15,
          ),
          BodyHighSearch(),
          ElevatedButton(
              onPressed: () =>
                  context.pushReplacement('/login-home-screen'),
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  fixedSize: Size(250, 50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Đăng xuất",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
