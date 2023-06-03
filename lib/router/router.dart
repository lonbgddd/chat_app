import 'package:chat_app/detail/detail_screen.dart';
import 'package:chat_app/home/home.dart';
import 'package:chat_app/home/profile/update_avatar.dart';
import 'package:chat_app/home/search.dart';
import 'package:chat_app/signup_or_signin/login_screen.dart';
import 'package:chat_app/signup_or_signin/signup_screen.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'detail',
          name: 'Home-detail',
          builder: (context, state) => ChatDetailScreen(
              uid: state.queryParameters['uid'],
              chatRomId: state.queryParameters['chatRomId'],
              name: state.queryParameters['name'],
              avatar: state.queryParameters['avatar']),
        ),
        GoRoute(
          path: 'update-avatar',
          builder: (context, state) => const UpdateProfileScreen(),
        ),
        GoRoute(
            path: 'search-user',
            builder: (context, state) => const SearchUserChat(),
            routes: [
              GoRoute(
                path: 'detail',
                name: 'detail',
                builder: (context, state) =>
                    ChatDetailScreen(uid: state.extra as String),
              ),
            ])
      ]),
  GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
            path: 'log-in',
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                path: 'sign-up',
                builder: (context, state) => const SignUpScreen(),
              )
            ]),
      ])
]);
