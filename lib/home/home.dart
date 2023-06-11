import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/chat_screen.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    BinderPage(),
    ChatScreen(),
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
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _onItemTapped,
        letIndexChange: (index) => true,
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        items: const [
          Icon(Icons.local_fire_department_rounded,
              size: 30, color: Colors.black),
          Icon(Icons.chat_bubble_outline_outlined,
              size: 30, color: Colors.black),
          Icon(Icons.favorite_border_outlined, size: 30, color: Colors.black),
          Icon(Icons.account_circle_outlined, size: 30, color: Colors.black),
        ],
      ),
    );
  }
}
