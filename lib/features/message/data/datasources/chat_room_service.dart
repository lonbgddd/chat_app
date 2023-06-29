import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

class ChatRoomService {
  const ChatRoomService();

  Stream<List<ChatRoomModel>> getChatRoomFromFireStore(String uid) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatRoomModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<ChatMessageModel>> getChatMessagesStream(String? chatRoomId) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessageModel.fromJson(doc.data()))
            .toList());
  }

  Stream<ChatMessageModel> getLastMessage(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      var doc = querySnapshot.docs.first;
      return ChatMessageModel.fromJson(doc.data());
    });
  }

  Future<void> addMessage(String uid, String chatRoomId, String messageContent,
      String imageUrl, String token) async {
    ChatMessageModel message = ChatMessageModel(
        uid: uid,
        messageText: messageContent,
        imageURL: imageUrl,
        time: DateTime.now());
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(message.toJson())
        .then((_) {
      FirebaseApi().sendPushMessage(message.messageText!, 'Tin nhắn', token);
    }).catchError((e) {
      print(e.toString());
    });
  }
}
