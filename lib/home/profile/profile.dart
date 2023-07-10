import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/home/profile/components/profile_avatar.dart';
import 'package:chat_app/home/setting/setting_screen.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../config/helpers/app_assets.dart';
import 'components/body_buy_premium.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        MediaQueryData mediaQueryData = MediaQuery.of(context);
        EdgeInsets padding = mediaQueryData.padding;

        return Container(
          padding: EdgeInsets.only(top: padding.top),
          height: MediaQuery.of(context).size.height,
          child: const SettingScreen(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileWatch>(context, listen: false).getUser();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iconTinder,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(223, 54, 64, 100), BlendMode.srcIn),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Binder",
                style: TextStyle(
                  fontFamily: 'Grandista',
                  fontSize: 24,
                  color: Color.fromRGBO(223, 54, 64, 100),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  AppAssets.iconShield,
                  color: Colors.grey,
                  width: 23,
                )),
            IconButton(
                onPressed: () => _showBottomModal(context),
                icon: Image.asset(
                  AppAssets.iconSetting,
                  color: Colors.grey,
                  width: 23,
                )),
          ],
        ),
        backgroundColor: Colors.white,
        body: getBody(context),
      ),
    );
  }

  Widget getBody(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: context.watch<ProfileWatch>().getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String fullName = snapshot.data!.fullName;
            List<String> splitName = fullName.split(" ");
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go('/home/update-profile');
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProfileAvatar(
                            avatarUrl: snapshot.data!.avatar,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${splitName[0]}, ${(DateTime.now().year - int.parse(snapshot.data!.birthday.substring(0, 4))).toString()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            fontSize: 20),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.verified,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BodyBuyPremium(),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
