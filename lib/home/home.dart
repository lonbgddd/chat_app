import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/message/message_screen.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

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
      items: const [
        BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.local_fire_department_rounded,
              size: 24,
            )),
        BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.chat_bubble,
              size: 24,
            )),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 24,
          ),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.purple,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}
