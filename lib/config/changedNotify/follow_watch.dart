import 'dart:async';

import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:flutter/cupertino.dart';

import '../../model/model.dart';

class FollowNotify extends ChangeNotifier {
  List<User> list = [];
  // String? _check;

  void initData() {
    list = [];
    // _check = null;
  }

  Future<List<Map<User, ChatRoom?>>> userFollowYou() async {
    try {
      List<Map<User, ChatRoom?>> result = [];
      String uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      List<User> userFollow = await DatabaseMethods().getUserFollow(uid);

      for (var user in userFollow) {
        if (user.post.contains(uid)) {
          ChatRoom chatRoom = await DatabaseMethods().getChatRoom(user.uid);
          result.add({user: chatRoom});
        } else {
          result.add({user: null});
        }
      }

      return result;
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

  Future<bool> checkMatch(String secondUid) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      String firstCheckString =
          await DatabaseMethods().checkFollow(uid, secondUid);
      String secondCheckString =
          await DatabaseMethods().checkFollow(secondUid, uid);
      if (firstCheckString == "follow" && secondCheckString == "follow") {
        return true;
      }
      return false;
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
