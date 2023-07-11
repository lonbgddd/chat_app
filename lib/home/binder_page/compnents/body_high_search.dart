
import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/widget/custom_field.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BodyHighSearch extends StatelessWidget {
  const BodyHighSearch({
    super.key,
  });

  void _showBottomModal({
    required BuildContext context,
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
            packageModel: packageBinderGoldList,
            color: Colors.yellow.shade700,
            assetsBanner: AppAssets.iconTinderGoldBanner,
            assetsIcon: AppAssets.iconTinderGold,
            title: "Binder",
            subTitle:
                'Xem thêm các hồ sơ phù hợp với tiêu chí của bạn bằng Binder Gold™',
            isHaveColor: true,
            isHaveIcon: false,
            iconData: null,
            isSuperLike: false,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: () => _showBottomModal(
        context: context,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
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
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                "Các lựa chọn tiêu chí giúp hiển thị những người hợp gu của bạn, nhưng sẽ không hạn chế việc bạn nhìn thấy những người khác - bạn sẽ vẫn có thể tương hợp với người nằm ngoài các lựa chọn tiêu chí của mình."),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            color: Colors.white,
            child: Column(
              children: [
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
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 12),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 2),
                  ),
                  child: Slider(
                    min: 1,
                    max: 9,
                    value: 1,
                    onChanged: (val) => _showBottomModal(
                      context: context,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Có viết tiểu sử",
                  isHaveSwitch: true,
                  isHaveIcon: false,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  isHaveIcon: false,
                  title: "Sở Thích",
                  isHaveSwitch: false,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  isHaveIcon: true,
                  title: "Mình đang tìm",
                  isHaveSwitch: false,
                  iconData: Icons.masks_outlined,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Cung Hoàng Đạo",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.looks,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Giáo dục",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.school_outlined,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  isHaveIcon: true,
                  title: "Gia đình tương lai",
                  iconData: Icons.shopping_cart_outlined,
                  isHaveSwitch: false,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Vắc xin COVID",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.masks,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  isHaveIcon: true,
                  iconData: Icons.extension,
                  title: "Kiểu Tính Cách",
                  isHaveSwitch: false,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Phong cách giao tiếp",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.messenger_sharp,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Ngôn ngữ tình yêu",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.messenger_sharp,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Thú cưng",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.pets,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Về việc uống bia rượu",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.wine_bar,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Bạn có hay hút thuốc không?",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.smoking_rooms,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Tập luyện",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.fitness_center,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Chế độ ăn uống",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.local_pizza_outlined,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Truyền thông xã hội",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.alternate_email,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                CustomField(
                  title: "Thói quen ngủ",
                  isHaveSwitch: false,
                  isHaveIcon: true,
                  iconData: Icons.wb_twighlight,
                  onTap: () => _showBottomModal(
                    context: context,
                  ),
                ),
              ],
            ),

          )
        ],
      ),
    );
  }
}
