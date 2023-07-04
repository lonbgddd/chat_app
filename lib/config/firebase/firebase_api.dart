import 'dart:convert';

import 'package:chat_app/config/firebase/key.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class FirebaseApi {
  static bool enablePermission = false;
  static String address ='';
  Future<void> permissionKey() async {
    final _message = FirebaseMessaging.instance;
    String? token = await _message.getToken();
    await HelpersFunctions.saveTokenUserSharedPreference(token!);
    if (kDebugMode) {
      print('Registration Token=$token');
    }
  }
  // Future<String?> checkPermissionLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return "isNotEnable";
  //   }
  //
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return "isDenied";
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return "isDeniedForever";
  //   }
  //   if (permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always) {
  //     return "isOnlyThisTime";
  //   }
  //
  //
  //   return null;
  // }

  Future checkPermissionLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Xử lý khi quyền bị từ chối
    } else if (permission == LocationPermission.deniedForever) {
      // Xử lý khi quyền bị từ chối mãi mãi
    } else {
      enablePermission = true;
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark placemark = placemarks[0];
      if (placemark.subThoroughfare != null) {
        address += '${placemark.subThoroughfare}, ';
      }
      if (placemark.thoroughfare != null) {
        address += '${placemark.thoroughfare}, ';
      }
      if (placemark.subAdministrativeArea != null) {
        address += '${placemark.subAdministrativeArea }, ';
      }
      if (placemark.administrativeArea != null) {
        address += '${placemark.administrativeArea }, ';
      }
      if (placemark.country != null) {
        address += '${placemark.country}';
      }
      print('Địa chỉ: $placemark');
    }
  }


  Future checkPermissionNotification() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
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
