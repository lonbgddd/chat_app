import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/config/helpers/helpers_user_and_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../GoogleAdMob/admob_helper.dart';
import '../../config/changedNotify/highlight_user_watch.dart';
import 'components/indicator_highlight_page.dart';

class HighlightScreen extends StatefulWidget {
  final String? currentUserID;
  final String? targetUserID;
  const HighlightScreen({Key? key, this.currentUserID, this.targetUserID})
      : super(key: key);

  @override
  State<HighlightScreen> createState() => _HighlightScreenScreenState();
}

class _HighlightScreenScreenState extends State<HighlightScreen> {

  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print(
        'CurrentUserID: ${widget.currentUserID} -  TargetUserID: ${widget.targetUserID} ');
    Provider.of<ProfileWatch>(context, listen: false).getUser();
    Provider.of<ProfileWatch>(context, listen: false)
        .getTargetUserUser(widget.targetUserID);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adProvider = Provider.of<AdMobProvider>(context, listen: false);
    adProvider.loadBannerAd(context);
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final adProvider = Provider.of<AdMobProvider>(context);
    final appLocal = AppLocalizations.of(context);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: padding.top),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 15),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  AppAssets.iconDelete,
                  width: 20,
                  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    appLocal.highlightPageTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    appLocal.highlightPageContent,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.76),
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: HelpersUserAndValidators.highlightPriceList.length,
                  itemBuilder: (context, index) {
                    var _scale = _selectedIndex == index ? 1.0 : 0.8;

                    return TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 350),
                      tween: Tween(begin: _scale, end: _scale),
                      curve: Curves.ease,
                      child: buildItemPageView(
                          HelpersUserAndValidators.highlightAppbarTitleList(context)[index].toUpperCase(),
                          HelpersUserAndValidators.highlightTitleTimeList(context)[index].toUpperCase(),
                          HelpersUserAndValidators.highlightPriceList[index],
                          HelpersUserAndValidators.highlightTimeList[index]),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                    );
                  }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    HelpersUserAndValidators.highlightPriceList.length,
                    (index) => Indicator(
                        isActive: _selectedIndex == index ? true : false)),
              ],
            ),
            Expanded(flex: 4, child: Container()),

            adProvider.isLoaded && adProvider.bannerAd != null ?
            Container(
                width: adProvider.bannerAd?.size.width.toDouble(),
                height: adProvider.bannerAd?.size.height.toDouble(),
                child: AdWidget(ad: adProvider.bannerAd!),
              ): SizedBox.shrink(),

          ],
        ),
      ),
    );
  }

  Widget buildItemPageView(
      String titleAppBar, String title, String price, int time) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: titleAppBar.isEmpty
                  ? Colors.white
                  : Color.fromRGBO(251, 233, 255, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Text(titleAppBar ?? '',
                style: TextStyle(
                    color: Color.fromRGBO(178, 27, 240, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          Text('$price ${AppLocalizations.of(context).highlightTimeRate}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 35,
          ),
          InkWell(
            onTap: () {
              Provider.of<HighlightUserNotify>(context, listen: false)
                  .startHighlight(context.read<ProfileWatch>().currentUser,
                      context.read<ProfileWatch>().targetUser, time);
              showDialogConfirm(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 55, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(180, 47, 248, 1),
                    const Color.fromRGBO(236, 119, 249, 1)
                  ],
                ),
              ),
              child: Text(
                AppLocalizations.of(context).highlightButtonText,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDialogConfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.iconTinder,
                  width: 55,
                  height: 55,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).highlightNotificationText,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.go('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: Color.fromRGBO(234, 64, 128, 1),
                      ),
                      child: Text( AppLocalizations.of(context).highlightConfirmButton,
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
