import 'dart:core';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NotificationWatch extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  List<dynamic> listNotification = [];

  Future getNotification() async {
    try {
      String? idUser = await HelpersFunctions().getUserIdUserSharedPreference();
      final data = await firestore
          .collection('notification')
          .doc(idUser)
          .collection('mess')
          .get();
      print(data.docs.length);
      listNotification = data.docs;
      return listNotification;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  String getId(int index) => listNotification[index]['avatar'] ?? "";

  Future saveNotification(
      {required String id,
      required String tyne,
      required String avatar,
      required String mess,
      required DateTime time}) async {
    try {
      String? idUser = await HelpersFunctions().getUserIdUserSharedPreference();

      firestore.collection('notification').doc(idUser).collection('mess').add({
        'uid': id,
        'tyne': tyne,
        'avatar': avatar,
        'mess': mess,
        'time': time,
        'status': 'false'
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
