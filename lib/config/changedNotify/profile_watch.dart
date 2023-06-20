import 'package:chat_app/config/data.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileWatch extends ChangeNotifier {
  String? _uid;

  Future<UserModal> getUser() async {
    try {
      _uid = await HelpersFunctions().getUserIdUserSharedPreference() as String;
      return await DatabaseServices(_uid).getUserInfo();
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<UserModal> getUserStream() async* {
    final uid = await HelpersFunctions().getUserIdUserSharedPreference();
    yield* DatabaseServices(uid).getUserInfoStream();
  }

  Future<UserModal> getDetailOthers(String? idUser) async {
    try {
      return await DatabaseServices(idUser).getUserInfo();
    } catch (e) {
      throw Exception(e);
    }
  }

  String get uid => _uid ?? "";
}
