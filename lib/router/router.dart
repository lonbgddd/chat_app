import 'package:chat_app/Auth/login_phone_screen.dart';
import 'package:chat_app/Auth/screen/confirm_profile.dart';
import 'package:chat_app/Auth/screen/verify_OTP.dart';
import 'package:chat_app/home/binder_page/compnents/show_me.dart';
import 'package:chat_app/home/home.dart';
import 'package:chat_app/home/message/search_Message.dart';
import 'package:chat_app/home/profile/detail_profile_others.dart';
import 'package:chat_app/home/profile/update_avatar.dart';
import 'package:chat_app/home/profile/update_profile_screen.dart';
import 'package:chat_app/welcom/request_position.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:go_router/go_router.dart';

import '../Auth/login_home_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'update-avatar',
          builder: (context, state) => const UpdateAvatarScreen(),
        ),
        GoRoute(
          path: 'update-profile',
          name: 'update-profile',
          builder: (context, state) => UpdateProfileScreen(
            uid: state.queryParameters['uid'],
          ),
        ),
        GoRoute(
          path: 'detail-others',
          name: 'Home-detail-others',
          builder: (context, state) => DetailProfileOthersScreen(
            uid: state.queryParameters['uid'],
          ),
        ),
        GoRoute(
          path: 'search-message',
          builder: (context, state) => SearchMessage(),
        ),
        GoRoute(
          path: 'show-me',
          builder: (context, state) => ShowMe(),
        )
      ]),
  GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
            path: 'request-permission-screen',
            builder: (context, state) => RequestPosition()),
      ]),
  GoRoute(
      path: '/login-home-screen',
      builder: (context, state) => const HomeScreenLogin(),
      routes: [
        GoRoute(
            path: 'confirm-screen',
            builder: (context, state) => const ConfirmProfile()),
        GoRoute(
            path: 'loginPhone',
            builder: (context, state) => LoginWithPhoneNumber(),
            routes: [
              GoRoute(
                  path: 'verify_otp', builder: (context, state) => VerifyOTP()),
            ]),
      ])
]);
