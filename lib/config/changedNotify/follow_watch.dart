import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:flutter/cupertino.dart';

import '../../model/model.dart';

class FollowNotify extends ChangeNotifier {
  List<User> list = [];
  String? _check;

  void initData() {
    list = [];
    _check = null;
  }

  Future<List<User>> userFollowYou() async {
    try {
      String uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      return await DatabaseMethods().getUserFollow(uid);
    } catch (e) {
      throw Exception(e);
    }
  }
}
