import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomField extends StatelessWidget {
  final bool isHaveSwitch;
  bool? onChanged;
  final Function() onTap;
  final String title;
  final String? select;
  final bool isHaveIcon;
  final IconData? iconData;

  CustomField(
      {super.key,
      required this.isHaveSwitch,
      this.onChanged,
      required this.isHaveIcon,
      required this.onTap,
      required this.title,
      this.iconData,
      this.select});

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
            packageModel: packageBinderGoldList(context),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  if (isHaveIcon)
                    Icon(
                      iconData,
                      color: Colors.grey,
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            isHaveSwitch
                ? CupertinoSwitch(
                    activeColor: Colors.red[400],
                    value: false,
                    onChanged: (newValue) => _showBottomModal(context: context),
                  )
                : Row(
                    children: [
                      Text(
                        select ?? 'Chọn',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey[800],
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
