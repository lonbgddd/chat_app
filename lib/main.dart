import 'package:chat_app/config/changedNotify/resposome.dart';
import 'package:chat_app/home/home.dart';
import 'package:chat_app/router/router.dart';
import 'package:chat_app/signup_or_signin/login_screen.dart';
import 'package:chat_app/signup_or_signin/signup_screen.dart';
import 'package:chat_app/welcom/welcom.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        create: (context) => CallDataProvider(),
        child: const SignUpScreen(),
      ),
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const HomePage(),
      ),
      ChangeNotifierProvider(
        create: (context) => CallDataProvider(),
        child: const WelcomeScreen(),
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
