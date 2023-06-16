import 'package:chat_app/Auth/widget/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/changedNotify/resposome.dart';

class HomeScreenLogin extends StatelessWidget {
  const HomeScreenLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = context.watch<CallDataProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/untitled.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 250),
            child: const Text(
              "Binder",
              style: TextStyle(
                  fontFamily: 'Grandista',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCustom(
                    text: "Sign in with Google",
                    image: "icons/google.png",
                    onPressed: () async {
                      await login.loginWithGoogle();
                      context.go('/confirm-screen');
                      // context.go('/home');
                    }),
                const SizedBox(
                  height: 15,
                ),
                ButtonCustom(
                  text: "Sign in with Phone Number",
                  image: "icons/phone-call.png",
                  onPressed: () => context.go('/login'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
