import 'package:chat_app/config/changedNotify/liked_user_card_provider.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_selection/components/item_selection_card.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/changedNotify/binder_watch.dart';

class BodySelection extends StatelessWidget {
  final _scrollController = ScrollController();

  BodySelection({Key? key}) : super(key: key);

  void _scrollListener(BuildContext context) {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent) {
      _showBottomModal(
        context: context,
        color: Colors.yellow,
        title: "Binder",
        isHaveIcon: false,
        packageModel: packageBinderGoldList,
        assetsBanner: AppAssets.iconTinderGoldBanner,
        assetsIcon: AppAssets.iconTinderGold,
        isHaveColor: true,
        subTitle: 'Quẹt từ các hồ sơ hấp dẫn nhất mỗi ngày',
      );
    }
  }

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

          padding: EdgeInsets.only(top: context.read<BinderWatch>().paddingTop),
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

  Widget getBody(BuildContext context, String gender, List<double> age,
      bool isInDistanceRange, double kilometres) {
    return FutureBuilder(
      future: context.read<BinderWatch>().allBinderSelectionUser(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 260,
            ),
            itemCount: context.watch<BinderWatch>().listCard.length,
            itemBuilder: (context, index) {
              return ItemSelectionCard(
                onTap: () {
                  Provider.of<LikedUserCardProvider>(context, listen: false)
                      .addFollow(
                          context.read<BinderWatch>().listCard[index].uid);
                  context.read<BinderWatch>().removeCardAtIndex(index);
                },
                user: context.read<BinderWatch>().listCard[index],
                isDetail: () => context.goNamed(
                  'Home-detail-others',
                  queryParameters: {
                    'uid': context
                        .read<BinderWatch>()
                        .listCard[index]
                        .uid
                        .toString()
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() => _scrollListener(context));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Nâng cấp lên Binder Gold™\nđể có thêm Top Tuyển chọn!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  getBody(context, "Mọi người", [18, 22], true, 290),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () => _showBottomModal(
                  context: context,
                  color: Colors.yellow,
                  isHaveIcon: false,
                  assetsBanner: AppAssets.iconTinderGoldBanner,
                  assetsIcon: AppAssets.iconTinderGold,
                  title: "Binder",
                  isHaveColor: true,
                  iconData: null,
                  packageModel: packageBinderGoldList,
                  subTitle:
                      'Thật nổi bật với lượt Siêu Thích và tăng gấp 3 lần khả năng tương hợp.',
                ),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  fixedSize: Size(280, 40),
                  backgroundColor: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "MỞ TÍNH NĂNG TOP TUYỂN CHỌN",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
