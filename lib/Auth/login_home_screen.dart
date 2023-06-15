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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCustom(
                    text: "Sign in with google",
                    image: "icons/google.png",
                    onPressed: () async {
                      await login.loginWithGoogle();
                      context.go('/home');
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: ButtonCustom(
                      text: "Sign in with facebook",
                      image: "icons/facebook.png",
                      onPressed: () {}),
                ),
                TextButton(
                  onPressed: () => context.go('/log-in'),
                  child: const Text("Continue with Email",
                      style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {
  final String? text;
  final String? image;
  final VoidCallback? onPressed;
  final Color? color;

  const ButtonCustom(
      {Key? key,
      required this.text,
      this.image,
      required this.onPressed,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/$image'),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                text ?? "null",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ));
  }
}
