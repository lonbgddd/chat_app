import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
            body: Column(
              children: [
                const Spacer(flex: 2),
                Image.network(
                    'https://png.pngtree.com/png-clipart/20190916/ourlarge/pngtree-cartoon-hand-drawn-promotion-work-performance-illustration-png-image_1730059.jpg'),
                const Spacer(flex: 3),
                Text(
                  "Find Your Perfect Match!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Discover and connect with like-minded individuals. Start your journey to love today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                FittedBox(
                  child: TextButton(
                      onPressed: () {
                        context.pushReplacement('/login-home-screen');
                        // snapshot.data == null
                        //     ? context.pushReplacement('/login-home-screen')
                        //     : context.go('/home');
                      },
                      child: Row(
                        children: [
                          Text(
                            "Skip",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
