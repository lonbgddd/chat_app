import 'package:chat_app/config/data.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/cupertino.dart';

class ProfileWatch extends ChangeNotifier {
  String? _uid;

  Future<User> getUser() async {
    try {
      _uid = await HelpersFunctions().getUserIdUserSharedPreference() as String;
      return await DatabaseServices(_uid).getUserInfors();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getDetailOthers(String? idUser) async {
    try {
      return await DatabaseServices(idUser).getUserInfors();
    } catch (e) {
      throw Exception(e);
    }
  }

  String get uid => _uid ?? "";
}
