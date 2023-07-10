import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/compnents/range_slider.dart';
import 'package:chat_app/home/binder_page/widget/custom_field.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BodyHighSearch extends StatelessWidget {
  const BodyHighSearch({super.key});

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
    final padding =
        MediaQueryData.fromView(WidgetsBinding.instance.window).padding;
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
    return GestureDetector(
      onTap: () {
        _showBottomModal(
          context: context,
          color: Colors.yellow.shade700,
          isHaveIcon: false,
          assetsBanner: AppAssets.iconTinderGoldBanner,
          assetsIcon: AppAssets.iconTinderGold,
          title: "Binder",
          isHaveColor: true,
          iconData: null,
          packageModel: packageBinderGoldList,
          subTitle:
              'Xem thêm các hồ sơ phù hợp với tiêu chí của bạn bằng Binder Gold™',
        );
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TÌM KIẾM CAO CẤP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade700,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3.0),
                      child: Text(
                        "Binder Gold™",
                        style: TextStyle(fontSize: 13),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "Các lựa chọn tiêu chí giúp hiển thị những người hợp gu của bạn, nhưng sẽ không hạn chế việc bạn nhìn thấy những người khác - bạn sẽ vẫn có thể tương hợp với người nằm ngoài các lựa chọn tiêu chí của mình."),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Số Lượng Ảnh Tối Thiểu',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '1',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.red[400],
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.white,
                overlayColor: Colors.red[400],
                trackHeight: 1,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 2),
              ),
              child: Slider(
                min: 1,
                max: 9,
                value: 1,
                onChanged: (val) {
                  _showBottomModal(
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
                        'Xem thêm các hồ sơ phù hợp với tiêu chí của bạn bằng Binder Gold™',
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Divider(
              indent: 15,
              thickness: 1,
            ),
            CustomField()
          ],
        ),
      ),
    );
  }
}
