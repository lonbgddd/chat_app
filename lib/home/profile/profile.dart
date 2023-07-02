import 'dart:io';

import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/home/profile/components/infor_row.dart';
import 'package:chat_app/home/profile/components/interest_item.dart';
import 'package:chat_app/home/profile/components/profile_avatar.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../config/helpers/app_assets.dart';
import 'components/body_buy_premium.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isVerified = false;

  @override
  void initState() {
    super.initState();
    // Provider.of<ProfileWatch>(context, listen: false).getUser();
  }

  @override
  Widget build(BuildContext context) {

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
                onPressed: () async {
                  context.read<CallDataProvider>().signOut();
                  context.pushReplacement('/login-home-screen');
                },
                icon: Icon(Icons.login,color: Colors.grey,)),
          ],
        ),
        backgroundColor: Colors.white,
        body: body(context),
      ),
    );
  }

  StreamBuilder<UserModel> body(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: context.watch<ProfileWatch>().getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String fullName = snapshot.data!.fullName;
            List<String> splitName = fullName.split(" ");
            return Column(
              mainAxisSize: MainAxisSize.max,
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
                      onTap: () {
                        setState(() {
                          isVerified = !isVerified;
                        });
                      },
                      child: Icon(
                        Icons.verified,
                        color: isVerified ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                BodyBuyPremium(),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
