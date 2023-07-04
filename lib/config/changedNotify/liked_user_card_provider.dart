import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:flutter/material.dart';

import '../../model/user_time.dart';

class LikedUserCardProvider extends ChangeNotifier {
  Future<ChatRoom?> checkMatched(String otherUid) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      String firstCheckString =
          await DatabaseMethods().checkFollow(uid, otherUid);
      if (firstCheckString == "follow") {
        ChatRoom? chatRoom = await DatabaseMethods().getChatRoom(otherUid);
        notifyListeners();
        return chatRoom;
      }
      return null;
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
        List<dynamic> userTimes = [UserTime(uid: uid, time: DateTime.now().toString()).toJson(),
          UserTime(uid: followId, time: DateTime.now().toString()).toJson()];
        Map<String, dynamic> chatRoom = {
          "users": users,
          "chatRoomId": chatRoomId,
          "userTimes": userTimes
        };
        await DatabaseMethods().addChatRoom(chatRoom, chatRoomId);
        notifyListeners();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future removeFollow(String followId) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      await DatabaseMethods().removeFollow(uid, followId);
      // notifyListeners();
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
