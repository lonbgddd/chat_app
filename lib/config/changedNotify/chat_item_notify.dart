import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class ItemChatNotify extends ChangeNotifier {
  Future<UserModal> getUserInformation(String? uid, String chatRoomId) async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) =>
            value.docs.map((e) => UserModal.fromJson(e.data())).single);
    return user;
  }

  getLastMessage(String chatRoomId) async {
    final chat = await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .limit(1)
        .get();
    notifyListeners();
    return ChatMessage.fromJson(chat.docs.first.data());
  }
}
