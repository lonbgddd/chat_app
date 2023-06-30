import 'package:chat_app/Auth/NOT_USE_login_screen.dart';
import 'package:chat_app/Auth/screen/confirm_profile.dart';
import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/changedNotify/chat_item_notify.dart';
import 'package:chat_app/config/changedNotify/confirm_profile_watch.dart';
import 'package:chat_app/config/changedNotify/detail_message.dart';
import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/config/changedNotify/home_state.dart';
import 'package:chat_app/config/changedNotify/home_watch.dart';
import 'package:chat_app/config/changedNotify/liked_user_card_provider.dart';
import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/changedNotify/login_phone.dart';
import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/search_message.dart';
import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/features/message/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/binder_page/compnents/item_card.dart';
import 'package:chat_app/home/group_chat/liked_user_card.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/home.dart';
import 'package:chat_app/home/message/itemMessage.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:chat_app/home/profile/update_avatar.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'Auth/login_phone_screen.dart';
import 'firebase_options.dart';
import 'home/message/detail_message.dart';
import 'home/message/search_Message.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  // showFlutterNotification(message);
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
//ios notification access
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  await FirebaseApi().permissionKey();
  await FirebaseApi().checkPermissionNotification();
  initializeDependencies();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const LoginScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => PageDataConfirmProfileProvider(),
        child: const ConfirmProfile(),
      ),
      ChangeNotifierProvider(
        create: (context) => BinderWatch(),
        child: const ProfileCard(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeState(),
        child: const HomePage(),
      ),
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const ConfirmProfile(),
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
        child: const UpdateAvatarScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeNotify(),
        child: const DetailMessage(),
      ),
      ChangeNotifierProvider(
        create: (context) => ItemChatNotify(),
        child: ItemMessage(),
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
        create: (context) => SearchMessageProvider(),
        child: SearchMessage(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginPhoneProvider(),
        child: LoginWithPhoneNumber(),
      ),
      ChangeNotifierProvider(
        create: (context) => DetailMessageProvider(),
        child: const DetailMessage(),
      ),
      ChangeNotifierProvider(
        create: (context) => LikedUserCardProvider(),
        child: const LikedUserCard(),
      ),
      BlocProvider<MessageBloc>(
        create: (context) => sl()..add(const GetChatRooms()),
        child: const MyMessageScreen(),
      ),
      // BlocProvider<ChatItemBloc>(
      //   create: (context) => sl(),
      //   child: MyItemMessage(),
      // ),
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
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
