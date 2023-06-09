import 'package:chat_app/Auth/screen/confirm_profile.dart';
import 'package:chat_app/GoogleAdMob/admob_helper.dart';
import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/changedNotify/chat_item_notify.dart';
import 'package:chat_app/config/changedNotify/confirm_profile_watch.dart';
import 'package:chat_app/config/changedNotify/follow_watch.dart';
import 'package:chat_app/config/changedNotify/highlight_user_watch.dart';
import 'package:chat_app/config/changedNotify/home_state.dart';
import 'package:chat_app/config/changedNotify/home_watch.dart';
import 'package:chat_app/config/changedNotify/liked_user_card_provider.dart';
import 'package:chat_app/config/changedNotify/location_provider.dart';
import 'package:chat_app/config/changedNotify/login_google.dart';
import 'package:chat_app/config/changedNotify/login_phone.dart';
// import 'package:chat_app/config/changedNotify/notification_watch.dart';
import 'package:chat_app/config/changedNotify/profile_watch.dart';
import 'package:chat_app/config/changedNotify/update_watch.dart';
import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/features/message/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/binder_page/components/item_card.dart';
import 'package:chat_app/home/group_chat/liked_user_card.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/home.dart';
import 'package:chat_app/home/notification/notification_screen.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/location/location_screen.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Auth/login_phone_screen.dart';
import 'config/changedNotify/notification_watch.dart';
import 'config/localizations/language_constants.dart';
import 'firebase_options.dart';
import 'home/profile/update_profile_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

void setupFirebaseMessaging() {
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Received message: ${message.notification?.title}');
    // Xử lý thông báo ở đây
    // Ví dụ: Hiển thị thông báo local, cập nhật UI, vv.
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
  MobileAds.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupFirebaseMessaging();
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  await FirebaseApi().permissionKey();
  await FirebaseApi().checkPermissionLocation();
  await FirebaseApi().checkPermissionNotification();

  initializeDependencies();
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PageDataConfirmProfileProvider(),
        child: const ConfirmProfile(),
      ),
      ChangeNotifierProvider(
        create: (context) => BinderWatch(),
        child: const ProfileCard(),
      ),
      ChangeNotifierProvider(
        create: (context) => HighlightUserNotify(),
        child: const ProfileCard(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProfileWatch(),
        child: const UpdateProfileScreen(),
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
        create: (context) => FollowNotify(),
        child: const WhoLikePage(),
      ),
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const WelcomeScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => NotificationWatch(),
        child: const NotificationScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginPhoneProvider(),
        child: LoginWithPhoneNumber(),
      ),
      ChangeNotifierProvider(
        create: (context) => LikedUserCardProvider(),
        child: const LikedUserCard(),
      ),
      ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child: LocationScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => UpdateNotify(),
        child: const UpdateProfileScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => AdMobProvider(),
        child: MyApp(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates, // Add this line,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
