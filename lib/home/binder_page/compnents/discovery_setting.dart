import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/home/binder_page/compnents/range_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DiscoverySetting extends StatefulWidget {
  const DiscoverySetting({Key? key}) : super(key: key);

  @override
  State<DiscoverySetting> createState() => _DiscoverySettingState();
}

class _DiscoverySettingState extends State<DiscoverySetting> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final selectOption = context.read<BinderWatch>();
    return Padding(
      padding: EdgeInsets.only(top: height / 70),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Text(""),
          title: Center(
            child: Text(
              "Discovery Settings",
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                context.pop('refresh');
              },
              child: Text(
                "Done",
                style: TextStyle(color: Colors.blue[700]),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderContainer(
              isAgePreference: false,
              title: "Distance Preference",
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              indent: 15,
              thickness: 1,
            ),
            InkWell(
              onTap: () => context.go('/home/show-me'),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Show me",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${selectOption.selectedOption}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              indent: 15,
              thickness: 1,
            ),
            SliderContainer(
              isAgePreference: true,
              title: "Age Preference",
            ),
          ],
        ),
      ),
    );
  }
}
