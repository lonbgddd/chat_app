import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../data_mothes.dart';

class HomeNotify extends ChangeNotifier {
  List<UserModal>? listUser = [];

  void initData() {
    listUser = [];
  }

  getUserChats() async {
    String uid =
        await HelpersFunctions().getUserIdUserSharedPreference() as String;
    return await DatabaseMethods().getUserChats(uid);
  }
}
