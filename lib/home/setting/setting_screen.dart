import 'package:chat_app/config/changedNotify/binder_watch.dart';
import 'package:chat_app/home/setting/components/body.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final provider = context.read<BinderWatch>();
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Cài Đặt",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          TextButton(
              onPressed:() async{
                await provider.updateRequestToShow();
                context.pop();} ,
              child: Text(
                "Xong",
                style: TextStyle(color: Colors.blueAccent),
              ))
        ],
        automaticallyImplyLeading: false,
        leading: Text(""),
      ),
      backgroundColor: Colors.grey[300],
      body: Body()

    );
  }
}
