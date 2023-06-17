import 'dart:convert';

import 'package:chat_app/config/firebase/key.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  Future<void> PemissionKey() async {
    final _message = FirebaseMessaging.instance;
    String? token = await _message.getToken();
    await HelpersFunctions.saveTokenUserSharedPreference(token!);
    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }

  Future<void> sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse(API_KEY),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$KEY',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }
}
