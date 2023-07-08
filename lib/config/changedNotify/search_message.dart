import 'package:chat_app/config/data_mothes.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../helpers/helpers_database.dart';

class SearchMessageProvider extends ChangeNotifier {
  String name = '';
  void search(String name) {
    this.name = name;
    notifyListeners();
  }

  Future<List<UserModel>> getListUserChat(String uid) async {
    try {
      List<UserModel> users = await DatabaseMethods().getListUserChat(uid);
      notifyListeners();
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }
  List<UserModel>? listUser = [];

  void initData() {
    listUser = [];
  }

  getUserChats() async {
    String uid =
    await HelpersFunctions().getUserIdUserSharedPreference() as String;
    return await DatabaseMethods().getUserChats(uid);
  }
}
