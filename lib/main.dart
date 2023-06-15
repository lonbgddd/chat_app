import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/changedNotify/chat_item_notify.dart';
import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/config/changedNotify/home_watch.dart';
import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/binder_page/compnents/item_card.dart';
import 'package:chat_app/home/chat_screen.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:chat_app/home/profile/update_avatar.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/Auth/login_screen.dart';
import 'package:chat_app/Auth/signup_screen.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/item_chat.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const LoginScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => BinderWatch(),
        child: const ProfileCard(),
      ),
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const SignUpScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileWatch(),
        child: const ProfileScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => BinderWatch(),
        child: const BinderPage(),
      ),
      ChangeNotifierProvider(
        create: (context) => UpdateNotify(),
        child: const UpdateProfileScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeNotify(),
        child: const ChatScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => FollowNotify(),
        child: const WhoLikePage(),
      ),
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const WelcomeScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => ItemChatNotify(),
        child: ChatRoomsTile(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
