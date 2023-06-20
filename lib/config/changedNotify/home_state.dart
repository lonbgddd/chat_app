import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeState extends ChangeNotifier {
  setStateUser(String status) async {
    final uid = await HelpersFunctions().getUserIdUserSharedPreference();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid.toString())
        .update({'activeStatus': status});
  }
}
