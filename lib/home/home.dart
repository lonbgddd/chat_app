import 'package:chat_app/config/changedNotify/home_state.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      print('Chuyển tới màn chat thành công');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    setupInteractedMessage();
    // FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // _selectedIndex != 1
    //     ? FirebaseMessaging.onMessage.listen(showFlutterNotification)
    //     : null;
    context.read<HomeState>().setStateUser('online');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    context.read<HomeState>().setStateUser('offline');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      context.read<HomeState>().setStateUser('offline');
    }
    if (state == AppLifecycleState.resumed) {
      context.read<HomeState>().setStateUser('online');
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    BinderPage(),
    MyMessageScreen(),
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
              onPressed: () {
                _onItemTapped(0);
              },
              icon: SvgPicture.asset(
                AppAssets.iconTinder,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 0
                        ? const Color.fromRGBO(229, 58, 69, 100)
                        : Colors.grey.shade600,
                    BlendMode.srcIn),
              ),
            )),
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {
                _onItemTapped(1);
              },
              icon: SvgPicture.asset(
                AppAssets.iconChatBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 1
                        ? const Color.fromRGBO(229, 58, 69, 100)
                        : Colors.grey.shade600,
                    BlendMode.srcIn),
              ),
            )),
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {
                _onItemTapped(2);
              },
              icon: SvgPicture.asset(
                AppAssets.iconLoveBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 2
                        ? const Color.fromRGBO(229, 58, 69, 100)
                        : Colors.grey.shade600,
                    BlendMode.srcIn),
              ),
            )),
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {
                _onItemTapped(3);
              },
              icon: SvgPicture.asset(
                AppAssets.iconProfileBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 3
                        ? const Color.fromRGBO(229, 58, 69, 100)
                        : Colors.grey.shade600,
                    BlendMode.srcIn),
              ),
            )),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: const Color.fromRGBO(223, 54, 64, 100),
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }
}
