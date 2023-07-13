import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/components/body_discovery_setting.dart';
import 'package:chat_app/home/binder_page/components/body_high_search.dart';
import 'package:chat_app/home/profile/widget/bottom_modal_fullscreen.dart';
import 'package:chat_app/home/setting/widget/card_custom.dart';
import 'package:chat_app/model/package_binder_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../Auth/widget/button_submit_page_view.dart';
import '../../../config/changedNotify/login_google.dart';
import '../../../config/localizations/language_constants.dart';
import '../../../main.dart';
import '../../../model/Language.dart';


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
    final appLocal = AppLocalizations.of(context);
    final currentLocal =  Localizations.localeOf(context);
    Language? selectedLanguage = Language.languageList().firstWhere(
          (language) => language.languageCode == currentLocal.languageCode,
      orElse: () => Language(0, "", "Unknown", ""),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardSettingCustom(
              onTap: () {
                _showBottomModal(
                  context: context,
                  color: Colors.black,
                  title: "Binder",
                  isHaveIcon: false,
                  packageModel: packageBinderPlatinumList(context),
                  assetsBanner: AppAssets.iconTinderPlatinumBanner,
                  assetsIcon: AppAssets.iconTinderPlatinum,
                  isHaveColor: true,
                  subTitle: appLocal.sliderCustomSubTitle1,
                );
              },
              assetsIcon: AppAssets.iconTinderPlatinum,
              assetsBanner: AppAssets.iconTinderPlatinumBanner,
              subTitle: appLocal.settingPageSubTitle1,
              width: size.width / 1,
              isHaveIcon: false),
          CardSettingCustom(
              onTap: () {
                _showBottomModal(
                  context: context,
                  color: Colors.yellow,
                  title: "Binder",
                  isHaveIcon: false,
                  packageModel: packageBinderGoldList(context),
                  assetsBanner: AppAssets.iconTinderGoldBanner,
                  assetsIcon: AppAssets.iconTinderGold,
                  isHaveColor: true,
                  subTitle: appLocal.sliderCustomSubTitle2,
                );
              },
              assetsIcon: AppAssets.iconTinderGold,
              assetsBanner: AppAssets.iconTinderGoldBanner,
              subTitle: appLocal.settingPageSubTitle2,
              width: size.width / 1,
              isHaveIcon: false),
          CardSettingCustom(
            onTap: () {
              _showBottomModal(
                context: context,
                color: Colors.red.shade200,
                title: "Binder",
                isHaveIcon: false,
                packageModel: packageBinderGoldList(context),
                assetsBanner: AppAssets.iconTinderPlusBanner,
                assetsIcon: AppAssets.iconTinder,
                isHaveColor: true,
                subTitle:appLocal.sliderCustomSubTitle3,
              );
            },
            assetsIcon: AppAssets.iconTinder,
            assetsBanner: AppAssets.iconTinderPlusBanner,
            subTitle: appLocal.settingPageSubTitle3,
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
                      packageModel: packageBinderSuperLike(context),
                      isSuperLike: true,
                      isHaveColor: true,
                      iconData: Icons.star,
                      isHaveIcon: true,
                      iconColor: Colors.blue,
                      color: Colors.blue[200]!,
                      title: appLocal.settingPageTitle1,
                      subTitle: appLocal.settingPageSubTitle4
                  );
                },
                subTitle:  appLocal.settingPageTitle1,
                isHaveIcon: true,
                iconData: Icons.star,
                iconColor: Colors.blue,
                width: size.width / 2.3,
                title: '',
              ),
              CardSettingCustom(
                onTap: () => context.goNamed('home-highlight-page'),
                subTitle:  appLocal.settingPageSubTitle5,
                isHaveIcon: true,
                iconData: Icons.bolt,
                iconColor: Colors.purple,
                width: size.width / 2.3,
                title: '',
              ),
            ],
          ),
          CardSettingCustom(
            subTitle: appLocal.settingPageSubTitle6,
            title: '',
            isHaveIcon: true,
            iconData: Icons.visibility_off_outlined,
            onTap: () {
              _showBottomModal(
                context: context,
                color: Colors.red.shade200,
                title: "Binder",
                isHaveIcon: false,
                packageModel: packageBinderGoldList(context),
                assetsBanner: AppAssets.iconTinderPlusBanner,
                assetsIcon: AppAssets.iconTinder,
                isHaveColor: true,
                subTitle: appLocal.settingPageSubTitle7,
              );
            },
            width: size.width / 1,
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              appLocal.settingPageSearchText,
              style:
                  TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
              child: BodyDiscoverySetting(isGlobal: false)),

          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 10),
            child: Text(
              appLocal.settingPageChangeLanguageText,
              style:
              TextStyle(fontWeight: FontWeight.bold,fontSize: 18, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width:  MediaQuery.of(context).size.width,
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    appLocal.settingPageLanguageCurrentText,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 5,

                  child: DropdownButton<Language>(
                    underline: SizedBox.shrink(),
                    elevation: 2,
                    icon: Row(
                      children:<Widget> [
                        Text(selectedLanguage.flag,
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 8,),
                        Text(selectedLanguage.name, style: TextStyle(
                            color: Colors.black
                        ),),
                        const SizedBox(width: 5,),
                        Icon(Icons.arrow_forward_ios_rounded, size: 15,color: Colors.black45,)
                      ],
                    ),
                    onChanged:(Language? language) async {
                      if (language != null) {
                        Locale _locale = await setLocale(language.languageCode);
                        MyApp.setLocale(context, _locale);
                      }
                    },

                    items: Language.languageList().map<DropdownMenuItem<Language>>(
                            (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text(
                                  e.flag,
                                  style: const TextStyle(fontSize: 25),
                                ),
                                const SizedBox(width: 8,),
                                Text(e.name, style: TextStyle(
                                    color: Colors.black
                                )),

                              ],
                            )
                        )
                    ).toList(),

                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20,),

          Container(
            width:  MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 60,left: 10,right: 10),
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
              color: Colors.white

            ),
            child: ElevatedButton(
              onPressed: () async {
                final signUp = context.read<CallDataProvider>();
                await signUp.signOut();
                context.pushReplacement('/login-home-screen');
              },
                style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.transparent,
              ),
            child: Text(appLocal.settingPageLogOutText, style: TextStyle(fontSize: 17, color:  Colors.black ,fontWeight: FontWeight.w500),)),
          ),

        ],
      ),
    );
  }
}
