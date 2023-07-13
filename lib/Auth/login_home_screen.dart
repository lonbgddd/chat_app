import 'package:chat_app/Auth/widget/button_custom_login_home.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/Language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/changedNotify/login_google.dart';
import '../config/firebase/firebase_api.dart';
import '../config/localizations/language_constants.dart';
import '../main.dart';

class HomeScreenLogin extends StatefulWidget {
  const HomeScreenLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenLoginState();
  }
}

class HomeScreenLoginState extends State<HomeScreenLogin> {
  bool isLoading = false;

  Future<void> isLoginGoogle() async {
    setState(() {
      isLoading = true;
    });
    final login = context.read<CallDataProvider>();
    String loginResult = await login.loginWithGoogle();
    if (loginResult == 'false') {
      context.go('/login-home-screen');
    } else if (loginResult == 'home') {
      context.go('/home');
    } else if (loginResult == 'confirm-screen') {
      context.go('/login-home-screen/confirm-screen');
    }

    setState(() {
      isLoading = false;
    });
  }

  // void _requestPermission() async {
  //   String? result = await FirebaseApi().checkPermissionLocation();
  //   print(result);
  //   if (result == 'isDenied' || result == null || result == 'isDeniedForever') {
  //     print(">>>>>>>>>>>>>>>>LOG:Chuyển đến màn hình nhập địa chỉ code file login_home_screen");
  //
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);

    return Scaffold(
      body: isLoading
          ? Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: Color.fromRGBO(234, 64, 128, 1),
          size: 100,
        ),
      )
          : Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromRGBO(238, 128, 95, 1),
              const Color.fromRGBO(234, 64, 128, 1)
            ],
          ),
        ),
        child: Stack(
          children:[
            Positioned(
                top: 40,
                right: 20,
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon:  const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 30,
                  ),
                  onChanged:(Language? language) async {
                    if (language != null) {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                    }
                  },

                  items: Language.languageList().map<DropdownMenuItem<Language>>(
                          (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          )
                      )
                  ).toList(),

                )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.iconTinder,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      colorFilter:
                      ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Finder",
                      style: TextStyle(
                          fontFamily: 'Grandista',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: appLocal.contentLogin1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: appLocal.contentLogin2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 17),
                          ),
                          TextSpan(
                              text: appLocal.contentLogin3),
                          TextSpan(
                            text:  appLocal.contentLogin4,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 17),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonCustom(
                        text: appLocal.titleGoogleSignInButton,
                        image: AppAssets.iconGG,
                        onPressed: () {
                          isLoginGoogle();
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtonCustom(
                      text: appLocal.titlePhoneNumberSignInButton,
                      image: AppAssets.iconPhone,
                      onPressed: () =>
                          context.go('/login-home-screen/loginPhone'),
                    ),
                  ],
                ),
              )
            ],
          ),]

        ),
      ),
    );
  }
}
