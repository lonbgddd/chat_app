import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/compnents/body_discovery_setting.dart';
import 'package:chat_app/home/binder_page/compnents/body_high_search.dart';
import 'package:chat_app/home/binder_page/widget/custom_field.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/setting/widget/card_custom.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(

          padding: EdgeInsets.only(top: context
              .read<BinderWatch>()
              .paddingTop),
          height: MediaQuery
              .of(context)
              .size
              .height,
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
    Size size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(

      padding: EdgeInsets.only(top: 10, bottom: 20),
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

          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: true,
              isHaveLastField: true,
              title: "CÀI ĐẶT TÀI KHOẢN",
              firstTitle: 'Số Điện Thoại',
              secondTitle: 'Tài khoản đã kết nối',
              lastTitle: 'Email',
              titles: ''),
          SizedBox(
            height: 25,
          ),
          BodyHighSearch(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 10),
            child: Text(
              "TÌM KIẾM",
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          BodyDiscoverySetting(isGlobal: true),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15, bottom: 10),
            child: Text(
              "NGÔN NGỮ ƯU TIÊN",
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          customFieldHasTextCenter(
              titles: 'Tiếng Việt', alignment: Alignment.topLeft, onTap: () {}),
          customFieldHasTextCenter(
              titles: 'English', alignment: Alignment.topLeft, onTap: () {}),
          customFieldHasTextCenter(
              titles: 'Thêm ngôn ngữ...',
              color: Colors.blue,
              alignment: Alignment.topLeft,
              onTap: () {}),
          SizedBox(
            height: 5,
          ),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: null,
              title: 'CÁC LIÊN HỆ',
              titles: 'Chặn liên hệ'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
                "Chọn những liên hệ bạn không muốn nhìn thấy hoặc\nkhông muộn họ nhìn thấy bạn trên Binder từ danh bạn của bạn."),
          ),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: null,
              isHaveTwoField: null,
              title: 'SỰ KIỆN HỎI & ĐÁP',
              titles: 'Quản lý Sự kiện Hỏi & Đáp'),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: null,
              isHaveTwoField: null,
              title: 'TOP TUYỂN CHỌN',
              titles: 'Quản lý Top Tuyển Chọn'),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: null,
              isHaveTwoField: null,
              title: "KHUNG GIỜ VÀNG",
              titles: 'Quản lý Khung Giờ Vàng'),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: null,
              title: "SỬ DỤNG DỮ LIỆU DI ĐỘNG",
              titles: 'Tự động phát video'),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: null,
              title: "TRẠNG THÁI HOẠT ĐỘNG",
              titles: 'Trạng thái Đang hoạt động'),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: 'Chọn tên người dùng',
              isHaveTwoField: null,
              title: "HỒ SƠ WEB",
              titles: 'Tên Người Dùng'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Text(
                "Tạo Tên Người Dùng công khai. Chia sẻ Tên Người Dùng của bạn để thành viên trên toàn thế giới có thể quẹt phải bạn trên Binder."),
          ),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: true,
              title: "THÔNG BÁO",
              isHaveLastField: true,
              firstTitle: 'Email',
              secondTitle: 'Thông Báo',
              lastTitle: 'Team Tinder',
              titles: ''),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child:
            Text("Chọn các thông báo muốn xem khi đang ở trong\nứng dụng."),
          ),
          SizedBox(
            height: 15,
          ),
          customFieldHasTextCenter(
              titles: 'Khôi phục giao dịch mua hàng', onTap: () {}),
          SizedBox(
            height: 35,
          ),
          customFieldHasTextCenter(titles: 'Chia sẻ Binder', onTap: () {}),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: null,
              title: 'LIỆN HỆ',
              titles: 'Trợ giúp & Hỗ trợ'),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: true,
              isHaveLastField: true,
              title: "CỘNG ĐỒNG",
              firstTitle: 'Quy tắc Cộng đồng',
              secondTitle: 'Bí quyết An toàn',
              lastTitle: 'Trung tâm An toàn',
              titles: ''),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveLastField: true,
              isHaveTwoField: true,
              title: "QUYỀN RIÊNG TƯ",
              firstTitle: 'Chính sách Cookie',
              secondTitle: 'Chính sách Quyền riêng tư',
              lastTitle: 'Tuỳ chọn Quyền riêng tư',
              titles: ''),
          customFieldHasOneElement(
              isHaveTitle: true,
              select: '',
              isHaveTwoField: true,
              title: "PHÁP LÝ",
              firstTitle: 'Giấy phép',
              secondTitle: 'Điều khoản Dịch Vụ',
              isHaveLastField: null,
              titles: ''),
          SizedBox(
            height: 35,
          ),
          customFieldHasTextCenter(
              titles: "Đăng xuất",
              onTap: () async {
                await context.read<CallDataProvider>().signOut();
                context.pushReplacement('/login-home-screen');
              }),
          SizedBox(
            height: 20,
          ),
          SvgPicture.asset(
            AppAssets.iconTinder,
            width: 45,
          ),
          Center(heightFactor: 3, child: Text("Phiên bản 14.12.0")),
          customFieldHasTextCenter(
              titles: "Xoá tài khoản",
              onTap: () {}),
        ]
        ,
      )
      ,
    );
  }


  Widget customFieldHasTextCenter({
    required String titles,
    Color? color,
    Alignment? alignment,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.white,
        alignment: alignment ?? Alignment.center,
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Text(
              titles,
              style: TextStyle(color: color ?? Colors.black),
            )),
      ),
    );
  }

  Widget customFieldHasOneElement({String? select,
    bool? isHaveTwoField,
    bool? isHaveTitle,
    bool? isHaveLastField,
    String? title,
    required String titles,
    String? firstTitle,
    String? secondTitle,
    String? lastTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isHaveTitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
            child: Text(
              title!,
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        isHaveTwoField == null
            ? Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: CustomField(
                isHaveSwitch: false,
                isHaveIcon: false,
                onTap: () {},
                select: '',
                title: titles),
          ),
        )
            : Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: CustomField(
                    isHaveSwitch: false,
                    isHaveIcon: false,
                    onTap: () {},
                    select: '',
                    title: firstTitle!),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: CustomField(
                    isHaveSwitch: false,
                    isHaveIcon: false,
                    onTap: () {},
                    select: '',
                    title: secondTitle!),
              ),
            ),
            if (isHaveLastField != null)
              Container(
                color: Colors.white,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: CustomField(
                      isHaveSwitch: false,
                      isHaveIcon: false,
                      onTap: () {},
                      select: '',
                      title: lastTitle!),
                ),
              )
          ],
        ),
      ],
    );
  }
}
