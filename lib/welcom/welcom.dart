import 'dart:async';

import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final checkLogin = context.watch<CallDataProvider>();
    return StreamBuilder<User?>(
      stream: checkLogin.user,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(238, 128, 95, 100),
                      Color.fromRGBO(234, 64, 128, 100),

                    ]),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 80),
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
                  InkWell(
                    onTap: () {
                      snapshot.data == null
                          ? context.pushReplacement('/login-home-screen')
                          : context.go('/home');
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 2,
                          color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text('Hẹn hò ngay',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
            ),
          );
        }
        {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
