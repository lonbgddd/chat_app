import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/home/binder_page/compnents/body_discovery_setting.dart';
import 'package:chat_app/home/binder_page/compnents/body_high_search.dart';
import 'package:chat_app/home/binder_page/compnents/range_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DiscoverySetting extends StatelessWidget {
  const DiscoverySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BinderWatch>();

    return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.4,
            title: Center(
              child: Text(
                "Cài đặt Tìm Kiếm",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await provider.updateRequestToShow();
                  context.pop("refresh");
                },
                child: Text(
                  "Xong",
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom:20),
            child: Column(
              children: [
                BodyDiscoverySetting(isGlobal: false),
                SizedBox(height: 25,),
                BodyHighSearch()
              ],
            ),
          ),

    );
  }
}
