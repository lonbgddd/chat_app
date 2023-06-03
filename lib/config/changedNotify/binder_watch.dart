import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/cupertino.dart';

class BinderWatch extends ChangeNotifier {
  List<User> list = [];
  String? _check;
  void initData() {
    list = [];
    _check = null;
  }

  Future<List<User>> allUserBinder() async {
    initData();
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;

      final users = await DatabaseMethods().getAllUser(uid);
      list = users ?? [];
      notifyListeners();
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future addFollow(String followId) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      await DatabaseMethods().addFollow(uid, followId);
      String check = await DatabaseMethods().checkFollow(uid, followId);
      if (check == "follow") {
        List<String> users = [uid, followId];
        String chatRoomId = getChatRoomId(uid, followId);
        Map<String, dynamic> chatRoom = {
          "users": users,
          "chatRoomId": chatRoomId,
        };
        await DatabaseMethods().addChatRoom(chatRoom, chatRoomId);
      }

      return check;
    } catch (e) {
      throw Exception(e);
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }
}
