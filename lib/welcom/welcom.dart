import 'dart:async';

import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkLogin = context.watch<CallDataProvider>();

    return StreamBuilder<User?>(
      stream: checkLogin.user,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        Timer(Duration(seconds: 3), () {
          snapshot.data == null ? context.go('/login-home-screen') : context.go('/home');
        });
        if (snapshot.connectionState == ConnectionState.active) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ const Color.fromRGBO(238, 128, 95, 1) ,const Color.fromRGBO(234, 64, 128, 1)],),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.iconTinder,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Binder',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Grandista',
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        }{
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
              color: Color.fromRGBO(234, 64, 128, 1), size: 100,
              ),
            ),
          );
        }
      },
    );
  }
}
