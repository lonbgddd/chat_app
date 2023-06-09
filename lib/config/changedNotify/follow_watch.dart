import 'dart:async';

import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/user_time.dart';
import 'package:flutter/cupertino.dart';

import '../../model/user_model.dart';

class FollowNotify extends ChangeNotifier {
  Future<List<UserModel>> userFollowYou() async {
    try {
      String uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      List<UserModel> userFollow = await DatabaseMethods().getUserFollow(uid);
      notifyListeners();
      return userFollow;
    } catch (e) {
      throw Exception(e);
    }
  }
}
