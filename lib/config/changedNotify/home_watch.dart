import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/cupertino.dart';

import '../data_mothes.dart';

class HomeNotify extends ChangeNotifier {
  List<User>? listUser = [];

  void initData() {
    listUser = [];
  }

  Future<List<User>?>? getUserChats() async {
    try {
      String uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      final users = DatabaseMethods().getUserChats(uid);
      print("Chao $users");
      return users;
    } catch (e) {
      print(e.toString());
    }
  }
}
