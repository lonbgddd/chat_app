import 'dart:io';

import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../features/message/data/models/user_time_model.dart';
import '../model/user_time.dart';

class DatabaseMethods {
  Future<List<UserModal>> searchByName(String searchField) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: searchField)
        .get();
    return data.docs.map((e) => UserModal.fromJson(e.data())).toList();
  }

  Future<List<UserModal>> getUserFollow(String uid) async {
    QuerySnapshot list = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    List<dynamic> listId = list.docs.single['followersList'];

    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: listId)
        .get();
    return data.docs.map((e) => UserModal.fromJson(e.data())).toList();
  }

  Future<List<UserModal>> getAllUser(String uid) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereNotIn: [uid]).get();
    print(data);
    return data.docs.map((e) => UserModal.fromJson(e.data())).toList();
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
      'followersList': FieldValue.arrayUnion([uid])
    });
  }

  Future removeFollow(String uid, String followId) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'followersList': FieldValue.arrayRemove([followId])
    });
  }

  Future<String> checkFollow(String uid, String followId) async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .where('followersList', arrayContains: followId)
        .get();
    if (data.docs.single['followersList'] != null) {
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

  Future<UserModal> getToken(String uid) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    return UserModal.fromJson(data.docs.first.data());
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

  Future<List<String>> pushListImage(List<File?> images, String uid) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final List<String> downloadURLs = [];
      final uuid = Uuid();

      for (File? image in images) {
        if (image != null) {
          final fileName = '${uuid.v4()}.${image.path.split('.').last}';
          final uploadTask = storageRef.child('images/$uid/$fileName').putFile(image);
          final snapshot = await uploadTask.whenComplete(() {});
          final downloadURL = await snapshot.ref.getDownloadURL();
          downloadURLs.add(downloadURL);
        }
      }

      return downloadURLs;
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

  Future updateUser(UserModal user) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(user.toJson());
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

  Future<bool> checkUserExists(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return true;
      }
    } catch (error) {
      // Lỗi xảy ra hoặc không thể kiểm tra người dùng
      print('Kiểm tra người dùng không thành công: $error');
    }
    return false;
  }

  Future<List<UserModal>> getListUserChat(String uid) async {
    List<String> listUid = [];
    List<UserModal> userList = [];
    try {
      await FirebaseFirestore.instance
          .collection("chatRoom")
          .where('users', arrayContains: uid)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        querySnapshot.docs.forEach((doc) {
          var listUid2 = doc['users'];
          for (var uid2 in listUid2) {
            if (uid != uid2) {
              listUid.add(uid2);
            }
          }
        });
        await FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: listUid)
            .get()
            .then((QuerySnapshot querySnapshot) {
          userList = querySnapshot.docs.map((doc) {
            UserModal user =
                UserModal.fromJson(doc.data() as Map<String, dynamic>);
            return user;
          }).toList();
        });
      });
      return userList;
    } catch (error) {
      print(error);
    }
    return userList;
  }


  Future<void> updateUserTime(String uid, String chatRoomId,String time) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("chatRoom").doc(chatRoomId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> userTimes = data['userTimes'];
        List<dynamic> list = [];
        for(dynamic index in userTimes){
          UserTime userTime = UserTime.fromJson(index);
          if(userTime.uid == uid){
            Map<String, dynamic> myObject = {'uid': uid,'time': time};
            list.add(myObject);
          }else{
            list.add(index);
          }
        }
        await FirebaseFirestore.instance
            .collection("chatRoom")
            .doc(chatRoomId)
            .update({
          "userTimes": list
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<String> getUserTime(String uid, String chatRoomId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("chatRoom").doc(chatRoomId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> userTimes = data['userTimes'];
        for(dynamic index in userTimes){
          UserTime userTime = UserTime.fromJson(index);
          if(userTime.uid == uid){
            return userTime.time;
          }
        }
      }
      return '';
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateAddressUser(String uid,String address) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'currentAddress': address});
    } catch (e) {
      throw Exception(e);
    }
  }

}
