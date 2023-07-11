import 'dart:io';

import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ntp/ntp.dart';

import '../../../../config/data_mothes.dart';
import '../../../../config/helpers/helpers_database.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

class ChatRoomService {
  const ChatRoomService();

  Stream<List<ChatRoomModel>> getChatRoomFromFireStore(String uid) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: uid)
        .orderBy('time', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<ChatRoomModel> list = [];
      for (var index in snapshot.docs) {
        await index.reference
            .collection('chats')
            .get()
            .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            ChatRoomModel chatRoom = ChatRoomModel.fromJson(index.data());
            list.add(chatRoom);
          }
        });
      }
      return list;
    });
  }

  Stream<List<ChatRoomModel>> getNewChatRoomFromFireStore(String uid) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: uid)
        .orderBy('time', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<ChatRoomModel> list = [];
      for (var index in snapshot.docs) {
        await index.reference
            .collection('chats')
            .get()
            .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
          } else {
            ChatRoomModel chatRoom = ChatRoomModel.fromJson(index.data());
            list.add(chatRoom);
          }
        });
      }
      return list;
    });
  }

  Stream<List<ChatRoomModel>> getAllChatRooms(String uid) {
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
      File? image, String avatar, String name) async {
    String nameUser = '';
    final uidChat = await HelpersFunctions().getUserIdUserSharedPreference();
    String avaterUser = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uidChat)
        .get()
        .then((value) {
      nameUser = value.docs.first.data()['fullName'];
      return value.docs.first.data()['avatar'];
    });

    String token = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) {
      return value.docs.first.data()['token'];
    });
    String imageUrl = '';
    DateTime currentTime = await NTP.now();
    String time = currentTime.toString();
    if (image != null) {
      imageUrl = await DatabaseMethods().pushImage(image, '$uid-$time');
    }
    ChatMessageModel message = ChatMessageModel(
        uid: uid,
        messageText: messageContent,
        imageURL: imageUrl,
        time: currentTime);
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(message.toJson())
        .then((_) {
      FirebaseApi().sendPushMessage(
          title: 'Tin nhắn',
          uid: uidChat.toString(),
          type: 'chat',
          chatRoomId: chatRoomId,
          body: message.messageText ?? "",
          avatar: avaterUser,
          name: nameUser,
          token: token);
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> compareUserTimeSelf(String uid, String chatRoomId) async {
    final chat = await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .limit(1)
        .get();
    ChatMessageModel lastChat =
        ChatMessageModel.fromJson(chat.docs.first.data());
    final myUserTime = await DatabaseMethods().getUserTime(uid, chatRoomId);
    DateTime? dateTimeA = lastChat.time!;
    DateTime dateTimeB = DateTime.parse(myUserTime);
    if (dateTimeA.compareTo(dateTimeB) > 0) {
      await DatabaseMethods()
          .updateUserTime(uid, chatRoomId, lastChat.time.toString());
    }
  }

  Stream<ChatRoomModel> getChatRoom(String uid, String chatRoomId) {
    try {
      return FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .snapshots()
          .asyncMap((doc) async {
        if (doc.data()!.containsKey('newChatRoom')) {
          List<dynamic> users = doc['newChatRoom'];
          String? myUid =
              await HelpersFunctions().getUserIdUserSharedPreference();
          if (users.isEmpty) {
            users.add(myUid);
            FirebaseFirestore.instance
                .collection("chatRoom")
                .doc(chatRoomId)
                .update({"newChatRoom": users});
          } else if (users.length < 2) {
            for (var user in users) {
              if (user != myUid) {
                users.add(myUid);
                FirebaseFirestore.instance
                    .collection("chatRoom")
                    .doc(chatRoomId)
                    .update({"newChatRoom": users});
              }
            }
          }
        }
        return ChatRoomModel.fromJson(doc.data()!);
      });
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<ChatRoomModel> getNewChatRoom(String chatRoomId) {
    try {
      return FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .get()
          .then((doc) => ChatRoomModel.fromJson(doc.data()!));
    } catch (e) {
      throw Exception('$e');
    }
  }
}
