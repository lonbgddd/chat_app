import 'dart:io';

import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseMethods {
  Future<List<User>> searchByName(String searchField) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: searchField)
        .get();
    return data.docs.map((e) => User.fromJson(e.data())).toList();
  }

  Future<List<User>> getUserFollow(String uid) async {
    QuerySnapshot list = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    // print(list.docs.single['post']);
    List<dynamic> listId = list.docs.single['post'];

    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: listId)
        .get();
    return data.docs.map((e) => User.fromJson(e.data())).toList();
  }

  Future<List<User>> getAllUser(String uid) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereNotIn: [uid]).get();
    return data.docs.map((e) => User.fromJson(e.data())).toList();
  }

  Future addChatRoom(chatRoom, chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {});
  }

  Future addFollow(String uid, String followId) async {
    await FirebaseFirestore.instance.collection('users').doc(followId).update({
      'post': FieldValue.arrayUnion([uid])
    });
  }

  Future removeFollow(String uid, String followId) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'post': FieldValue.arrayRemove([followId])
    });
  }

  Future<String> checkFollow(String uid, String followId) async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .where('post', arrayContains: followId)
        .get();
    if (data.docs.single['post'] != null) {
      return 'follow';
    }
    {
      return 'no';
    }
    // print(data.map((event) => event.docs.length));
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<void> addMessage(
      String chatRoomId, ChatMessage chatMessageData, String token) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData.toJson())
        .then((_) {
      FirebaseApi()
          .sendPushMessage(chatMessageData.messageText, 'Tin nhắn', token);
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<User> getToken(String uid) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    return User.fromJson(data.docs.first.data());
  }

  Future<String> pushImage(File? image, String uid) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      await storageRef.child('images/$uid').putFile(image!);
      return storageRef.child('images/$uid').getDownloadURL();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateAvatar(String avatar, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'avatar': avatar});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getUserChats(String uid) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: uid)
        .snapshots();
  }

  Future<ChatRoom> getChatRoom(String secondUid) async {
    String? uid = await HelpersFunctions().getUserIdUserSharedPreference();
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: uid)
        .get();

    final List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    final List<QueryDocumentSnapshot> filteredDocuments = [];

    for (final doc in documents) {
      final users = doc.get('users') as List<dynamic>;
      if (users.contains(secondUid)) {
        filteredDocuments.add(doc);
      }
    }

    final DocumentSnapshot document = filteredDocuments.first;
    return ChatRoom.fromJson(document.data() as Map<String, dynamic>);
    // Handle the document data as needed
  }
}
