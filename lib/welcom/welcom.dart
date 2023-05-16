import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  Future goLogin(BuildContext context) {
    return Future.delayed(
      const Duration(seconds: 3),
      () => context.go('/log-in'),
    );
  }

  @override
  Widget build(BuildContext context) {
    // goLogin(context);
    final checkLogin = context.watch<CallDataProvider>();

    return StreamBuilder<User?>(
      stream: checkLogin.user,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Image.network(
                      'https://png.pngtree.com/png-clipart/20190916/ourlarge/pngtree-cartoon-hand-drawn-promotion-work-performance-illustration-png-image_1730059.jpg'),
                  const Spacer(flex: 3),
                  Text(
                    "Welcome to our freedom \nmessaging app",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    "Freedom talk any person of your \n mother language.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ),
                  const Spacer(flex: 3),
                  FittedBox(
                    child: TextButton(
                        onPressed: () {
                          snapshot.data == null
                              ? context.go('/log-in')
                              : context.go('/home');
                        },
                        child: Row(
                          children: [
                            Text(
                              "Skip",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.8),
                                  ),
                            ),
                            const SizedBox(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.8),
                            )
                          ],
                        )),
                  )
                ],
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
