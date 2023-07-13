
import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/profile/components/slider.dart';
import 'package:chat_app/home/profile/widget/bottom_modal.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/profile/widget/custom_card.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyBuyPremium extends StatefulWidget {
  const BodyBuyPremium({Key? key}) : super(key: key);

  @override
  State<BodyBuyPremium> createState() => _BodyBuyPremiumState();
}

class _BodyBuyPremiumState extends State<BodyBuyPremium> {
  void _showModal() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => BottomModal());
  }

  void _showBottomModal(
      {required Color color,
      Color? iconColor,
      bool? isHaveColor,
      required bool isHaveIcon,
      bool? isSuperLike,
      List<PackageModel>? packageModel,
      IconData? iconData,
      required BuildContext context,
      required String subTitle,
      required String title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);
        EdgeInsets padding = mediaQueryData.padding;

        return Container(
          padding: EdgeInsets.only(top: padding.top),
          height: MediaQuery.of(context).size.height,
          child: BottomModalFullScreen(
            color: color,
            title: title,
            subTitle: subTitle,
            packageModel: packageModel,
            iconColor: iconColor,
            isHaveColor: isHaveColor ?? false,
            isHaveIcon: isHaveIcon,
            iconData: iconData,
            isSuperLike: isSuperLike ?? false,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 70),
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
                      context: context,
                      packageModel: packageBinderSuperLike(context),
                      isSuperLike: true,
                      isHaveColor: true,
                      iconData: Icons.star,
                      isHaveIcon: true,
                      iconColor: Colors.blue,
                      color: Colors.blue[200]!,
                      title: appLocal.bodyBuyPremiumTitle,
                      subTitle: appLocal.bodyBuyPremiumContent,
                  ),
                  iconColor: Colors.blue,
                  icon: Icons.star,
                  title: appLocal.bodyBuyPremiumContentSuperLikesText,
                  subtitle: appLocal.bodyBuyPremiumButtonText,
                  isIcon: true,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  isIcon: true,
                  onTap: _showModal,
                  iconColor: Colors.purple,
                  icon: Icons.bolt,
                  title: appLocal.bodyBuyPremiumContentSuperBoostsText,
                  subtitle: appLocal.bodyBuyPremiumButtonText,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: CustomCard(
                  isIcon: false,
                  onTap: () {},
                  title: appLocal.bodyBuyPremiumSubscriptionText,
                ),
              ),
            ],
          ),
          const SliderCustom(),
        ],
      ),
    );
  }
}
