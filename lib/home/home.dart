import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/message/message_screen.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _token;
  String? initialMessage;
  bool _resolved = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              _resolved = true;
              initialMessage = value?.data.toString();
            },
          ),
        );
    _selectedIndex != 1
        ? FirebaseMessaging.onMessage.listen(showFlutterNotification)
        : null;
  }

  static final List<Widget> _widgetOptions = <Widget>[
    BinderPage(),
    MessageScreen(),
    WhoLikePage(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  BottomNavigationBar _bottomNavigation() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 2,
      items: [
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {_onItemTapped(0);},
              icon: SvgPicture.asset(AppAssets.iconTinder,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(_selectedIndex == 0 ? Color.fromRGBO(229, 58, 69, 100): Colors.grey.shade600, BlendMode.srcIn),
                ),
            )
        ),

        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {_onItemTapped(1);},
              icon: SvgPicture.asset(AppAssets.iconChatBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(_selectedIndex == 1 ? Color.fromRGBO(229, 58, 69, 100): Colors.grey.shade600, BlendMode.srcIn),
              ),
            )        ),
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {_onItemTapped(2);},
              icon: SvgPicture.asset(AppAssets.iconLoveBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(_selectedIndex == 2 ? Color.fromRGBO(229, 58, 69, 100): Colors.grey.shade600, BlendMode.srcIn),
              ),
            )        ),
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: (){_onItemTapped(3);},
              icon: SvgPicture.asset(AppAssets.iconProfileBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(_selectedIndex == 3 ? Color.fromRGBO(229, 58, 69, 100): Colors.grey.shade600, BlendMode.srcIn),
              ),
            )
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color.fromRGBO(223, 54, 64, 100),
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }



}
