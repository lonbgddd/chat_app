import 'package:chat_app/Auth/login_phone_screen.dart';
import 'package:chat_app/Auth/screen/confirm_profile.dart';
import 'package:chat_app/Auth/screen/verify_OTP.dart';
import 'package:chat_app/home/binder_page/compnents/show_me.dart';
import 'package:chat_app/home/profile/update_profile_screen.dart';
import 'package:chat_app/location/location_screen.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../Auth/login_home_screen.dart';
import '../features/message/presentation/bloc/detail_message/detail_message_bloc.dart';
import '../features/message/presentation/widgets/detail_message.dart';
import '../home/binder_page/highlight_page.dart';
import '../home/home.dart';
import '../features/message/presentation/screens/search_Message.dart';
import '../home/notification/notification_screen.dart';
import '../home/profile/detail_profile_others.dart';
import '../injection_container.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'notification-page',
          builder: (context, state) => const NotificationScreen(),
        ),
        GoRoute(
          path: 'update-profile',
          name: 'update-profile',
          builder: (context, state) => const UpdateProfileScreen(),
        ),
        GoRoute(
          path: 'detail-others',
          name: 'home-detail-others',
          builder: (context, state) => DetailProfileOthersScreen(
            uid: state.queryParameters['uid'],
          ),
        ),
        GoRoute(
          path: 'highlight-page',
          name: 'home-highlight-page',
          builder: (context, state) => HighlightScreen(
            currentUserID: state.queryParameters['currentUserID'],
            targetUserID: state.queryParameters['targetUserID'],
          ),
        ),
        GoRoute(
          path: 'search-message',
          name: 'search-message',
          builder: (context, state) => SearchMessage(),
        ),
        GoRoute(
            path: 'detail-message',
            name: 'detail-message',
            builder: (context, state) => BlocProvider<DetailMessageBloc>(
                  create: (context) {
                    return sl()
                      ..add(GetMessageList(state.queryParameters['uid']!,
                          state.queryParameters['chatRoomId']!, false));
                  },
                  child: DetailMessage(
                    uid: state.queryParameters['uid'],
                    chatRoomId: state.queryParameters['chatRoomId'],
                    name: state.queryParameters['name'],
                    avatar: state.queryParameters['avatar'],
                    token: state.queryParameters['token'],
                  ),
                )),
        GoRoute(
          path: 'show-me',
          builder: (context, state) => ShowMe(),
        ),
        GoRoute(
            path: 'location-screen',
            name: 'location-screen',
            builder: (context, state) => LocationScreen()),
      ]),
  GoRoute(
    path: '/',
    builder: (context, state) => const WelcomeScreen(),
  ),
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
