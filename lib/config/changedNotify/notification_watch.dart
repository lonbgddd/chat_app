import 'dart:core';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NotificationWatch extends ChangeNotifier {
  final fireStore = FirebaseFirestore.instance;
  List<dynamic> listNotification = [];

  Future getNotification() async {
    try {
      String? idUser = await HelpersFunctions().getUserIdUserSharedPreference();
      final data = await fireStore
          .collection('notification')
          .doc(idUser)
          .collection('mess')
          .orderBy('time')
          .get();
      listNotification = data.docs;
      notifyListeners();
      return listNotification;
    } catch (e) {
      throw Exception(e);
    }
  }

  String getId(int index) => listNotification[index]['avatar'] ?? "";

  Future saveNotification(
      {required String id,
      required String type,
      required String avatar,
      required String mess,
      required String name,
      required String chatRoomId,
      required DateTime time}) async {
    try {
      String? idUser = await HelpersFunctions().getUserIdUserSharedPreference();
      print('Truyền vaò $type');
      fireStore.collection('notification').doc(idUser).collection('mess').add({
        'uid': id,
        'type': type,
        'avatar': avatar,
        'mess': mess,
        'name': name,
        'chatRoomId': chatRoomId,
        'time': time.toIso8601String(),
        'status': 'false'
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
