import 'package:chat_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<List<User>> searchByName(String searchField) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: searchField)
        .get();
    return data.docs.map((e) => User.fromJson(e.data())).toList();
  }

  Future addChatRoom(chatRoom, chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<List<User>?>? getUserChats(String uid) async {
    final userIdList = FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: uid)
        .snapshots();

    print('listIdUser get  $userIdList');
    return FirebaseFirestore.instance
        .collection('user')
        .where('uid', arrayContains: userIdList)
        .get()
        .then(
            (value) => value.docs.map((e) => User.fromJson(e.data())).toList());
  }
}
