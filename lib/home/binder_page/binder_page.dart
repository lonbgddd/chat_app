import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/binder_page/compnents/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../config/helpers/app_assets.dart';
import '../../config/helpers/helpers_database.dart';

class BinderPage extends StatefulWidget {
  const BinderPage({Key? key}) : super(key: key);

  @override
  State<BinderPage> createState() => _BinderPageState();
}

class _BinderPageState extends State<BinderPage> with SingleTickerProviderStateMixin{
  late Animation _animation;
  late AnimationController _animationController;
  var listRadius = [50.0,100.0,150.0,200.0];

  Future<List<String>> _savePositionUser() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print("${position.latitude}|${position.longitude}");
    await HelpersFunctions.savePositionTokenSharedPreference(
        [position.latitude.toString(), position.longitude.toString()]);
    return [position.longitude.toString(), position.latitude.toString()];
  }


  @override
  void initState() {
    super.initState();
    Provider.of<BinderWatch>(context, listen: false).allUserBinder;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<BinderWatch>(context, listen: false);
      provider.setScreenSize(size);
      provider.initializeSelectedOption();
      _savePositionUser().then((position) {
        provider.updatePositionUser(position);
      });
    });
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 2), lowerBound: 0.5);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  bool hasNotification = false;
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BinderWatch>();
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iconTinder,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Binder",
                style: TextStyle(
                  fontFamily: 'Grandista',
                  fontSize: 24,
                  color: Color.fromRGBO(223, 54, 64, 100),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                  if (hasNotification)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.tune,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: getBody(provider.selectedOption, provider.currentAgeValue,
            provider.showPeopleInRangeDistance, provider.distancePreference),
    );
  }

  Widget getBody(String gender, List<double> age, bool isInDistanceRange,
      double kilometres) {
    return FutureBuilder(
      future: context
          .read<BinderWatch>()
          .allUserBinder(gender, age, isInDistanceRange, kilometres),
      builder: (context, snapshot) => snapshot.hasData
          ? Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
            alignment: Alignment.center,
            children: context
                .watch<BinderWatch>()
                .listCard
                .reversed
                .map((e) => ProfileCard(
              user: e,
              isDetail: () => context.goNamed(
                  'Home-detail-others',
                  queryParameters: {
                    'uid': e.uid.toString(),
                  }),
              isFont:
              context.watch<BinderWatch>().listCard.first ==
                  e,
            ))
                .toList()),
      )
          : Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: Color.fromRGBO(234, 64, 128, 100),
          size: 70,
        ),
      ),
    );
  }

  Widget buildLoadingContainer(radius) {
    return Container(
      width: radius * _animationController.value,
      height: radius * _animationController.value,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
          Color.fromRGBO(234, 64, 128, 1.0 - _animationController.value)),
    );
  }
}
