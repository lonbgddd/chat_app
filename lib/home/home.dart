import 'package:chat_app/config/changedNotify/home_state.dart';
import 'package:chat_app/config/helpers/app_assets.dart';
import 'package:chat_app/home/binder_page/binder_page.dart';
import 'package:chat_app/home/group_chat/who_like_page.dart';
import 'package:chat_app/home/profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Auth/widget/button_submit_page_view.dart';
import '../config/changedNotify/notification_watch.dart';
import '../config/changedNotify/profile_watch.dart';
import '../config/data_mothes.dart';
import '../config/firebase/firebase_api.dart';
import '../config/helpers/helpers_database.dart';
import '../features/message/presentation/bloc/message/message_bloc.dart';
import '../features/message/presentation/screens/message_screen.dart';
import '../injection_container.dart';
import '../main.dart';

import 'binder_selection/binder_selection.dart';

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

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((event) async {
      String uid = await event.data['id'];
      event.data['type'] != 'chat'
          ? {
              NotificationWatch().saveNotification(
                  id: uid,
                  type: 'match',
                  name: event.notification?.title ?? "",
                  chatRoomId: event.data['chatRoomId'],
                  avatar: event.data['avatar'],
                  mess: event.notification?.title ?? "",
                  time: DateTime.now()),
              showMatchDialog(context,
                  avatar: event.data['avatar'],
                  name: event.data['name'] ?? "",
                  uid: uid)
            }
          : _selectedIndex == 1
              ? null
              : {
                  showFlutterNotification(event),
                  NotificationWatch().saveNotification(
                      id: uid,
                      name: event.data['name'],
                      chatRoomId: event.data['chatRoomId'],
                      type: event.data['type'],
                      avatar: event.data['avatar'],
                      mess: event.notification?.body ?? "",
                      time: DateTime.now())
                };
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    message.data['type'] != 'chat'
        ? showMatchDialog(context,
            avatar: message.data['avatar'],
            name: 'Tài',
            uid: message.data['id'].toString())
        : showFlutterNotification(message);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    setupInteractedMessage();
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
    // context.read<HomeState>().setStateUser('offline');
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
    const BinderPage(),
    BlocProvider<MessageBloc>(
        create: (context) => sl()..add(const GetChatRooms()),
        child: const MyMessageScreen()),
    BinderSelection(),
    const WhoLikePage(),
    const ProfileScreen(),
    MyMessageScreen(),
    WhoLikePage(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> checkPermissionLocation() async {
    if (FirebaseApi.enablePermission) {
      String address = '';
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      if (placemark.subThoroughfare != null) {
        address += '${placemark.subThoroughfare}, ';
      }
      if (placemark.thoroughfare != null) {
        address += '${placemark.thoroughfare}, ';
      }
      if (placemark.subAdministrativeArea != null) {
        address += '${placemark.subAdministrativeArea}, ';
      }
      if (placemark.administrativeArea != null) {
        address += '${placemark.administrativeArea}, ';
      }
      if (placemark.country != null) {
        address += '${placemark.country}';
      }
      String? uid = await HelpersFunctions().getUserIdUserSharedPreference();
      await DatabaseMethods().updateAddressUser(uid!, address);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkPermissionLocation();
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
                        ? const Color.fromRGBO(229, 58, 69, 1)
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
                        ? const Color.fromRGBO(229, 58, 69, 1)
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
                AppAssets.iconStar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 2
                        ? const Color.fromRGBO(243, 214, 119, 1)
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
                AppAssets.iconLoveBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 3
                        ? const Color.fromRGBO(229, 58, 69, 1)
                        : Colors.grey.shade600,
                    BlendMode.srcIn),
              ),
            )),
        BottomNavigationBarItem(
            label: '',
            icon: IconButton(
              onPressed: () {
                _onItemTapped(4);
              },
              icon: SvgPicture.asset(
                AppAssets.iconProfileBottomBar,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    _selectedIndex == 4
                        ? const Color.fromRGBO(229, 58, 69, 100)
                        : Colors.grey.shade600,
                    BlendMode.srcIn),
              ),
            )),
      ],
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
    );
  }

  void showMatchDialog(BuildContext context,
      {required String avatar, required String name,required String uid}) {
    final Size screenSize = MediaQuery.of(context).size;
    final double dialogWidth = screenSize.width;
    final double dialogHeight = screenSize.height * 0.4;
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(AppLocalizations.of(context).notificationMatchTitle, style: TextStyle(fontSize: 22),),
          content: Container(
            height: dialogHeight,
            width: dialogWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(AppLocalizations.of(context).notificationMatchContent),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(context.read<ProfileWatch>().currentUser.avatar.toString()),
                            ),
                            const SizedBox(height: 10),
                            Text(context.read<ProfileWatch>().currentUser.fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                )
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Image(image: AssetImage(AppAssets.iconMatch),),
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(avatar.toString()),
                            ),
                            const SizedBox(height: 10),
                            Text(name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                )
                            ),
                          ],
                        ),


                      ],
                    ),

                  ],
                ),

                ButtonSubmitPageView(text: AppLocalizations.of(context).notificationButtonMatch, marginBottom: 10, color: Colors.transparent, onPressed: (){context.pop();}),

              ],
            ),
          ),

        );
      },
    );
  }

}
