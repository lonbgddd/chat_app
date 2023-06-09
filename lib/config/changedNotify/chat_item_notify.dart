import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../data_mothes.dart';

class ItemChatNotify extends ChangeNotifier {
  Future<UserModel> getUserInformation(String? uid, String chatRoomId) async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) =>
            value.docs.map((e) => UserModel.fromJson(e.data())).single);
    return user;
  }

  getLastMessage(String chatRoomId) async {
    try{
      final chat = await FirebaseFirestore.instance
          .collection('chatRoom')
          .doc(chatRoomId)
          .collection('chats')
          .orderBy('time', descending: true)
          .limit(1)
          .get();
      notifyListeners();
      return ChatMessage.fromJson(chat.docs.first.data());
    }catch (error){
      print(error);
    }
  }
}
