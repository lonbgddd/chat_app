import 'dart:io';
import 'dart:math';

import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  Future<List<UserModel>> searchByName(String searchField) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: searchField)
        .get();
    return data.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<UserModel>> getUserFollow(String uid) async {
    QuerySnapshot list = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    List<dynamic> listId = list.docs.single['followersList'];

    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereIn: listId)
        .get();
    return data.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  Future<List<UserModel>> getUserHasFilter(
      String uid, String? gender, List<double> age) async {
    Query query = FirebaseFirestore.instance
        .collection('users')
        .where('uid', whereNotIn: [uid]);
    QuerySnapshot snapshot;

    if (gender != 'Mọi người') {
      query = query.where('gender', isEqualTo: gender);
    }

    if (age.first == 18 || age.first != 18) {
      query = query.where('birthday', isNotEqualTo: null);
      snapshot = await query.get();
      final List<UserModel> userModals = [];

      for (var e in snapshot.docs) {
        final userData = e.data() as Map<String, dynamic>;
        final birthday = userData['birthday'];
        String yyyy = birthday.toString().substring(0, 4);
        int userAge = DateTime.now().year - int.parse(yyyy);
        // input[22,20,20,23,20]
        //condition   22<=age <=30
        if ((userAge >= age.first - 1 && userAge <= age.last) ||
            age.first == userAge) {
          print(
              '${userData['email'].toString().split(" ").first} is $userAge years old. not in range');

          final userModal = UserModel.fromJson(userData);
          userModals.add(userModal);
        }
      }

      return userModals;
    }

    snapshot = await query.get();

    return snapshot.docs.map<UserModel>((DocumentSnapshot e) {
      return UserModel.fromJson(e.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<UserModel>> getUserHasFilterKm(String uid, String? gender, List<double> age, double kilometres) async {
    Query query = FirebaseFirestore.instance.collection('users').where('uid', whereNotIn: [uid]);
    QuerySnapshot snapshot;

    if (gender != 'Mọi người') {
      query = query.where('gender', isEqualTo: gender);
    }

    if (age.first == 18 || age.first != 18) {
      query = query.where('birthday', isNotEqualTo: null);
      snapshot = await query.get();
      final List<UserModel> userModals = [];


      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final userPosition = userData['position'];
        double userLatitude = double.parse(userPosition.first);
        double userLongitude = double.parse(userPosition.last);

        for (var e in snapshot.docs) {
          final userData = e.data() as Map<String, dynamic>;
          final birthday = userData['birthday'];
          final position = userData['position'];
          String yyyy = birthday.toString().substring(0, 4);
          int userAge = DateTime.now().year - int.parse(yyyy);

          double userPositionLatitude = double.parse(position!.first);
          double userPositionLongitude = double.parse(position.last);

          double distance = _calculateDistance(
            userLatitude,
            userLongitude,
            userPositionLatitude,
            userPositionLongitude,
          );

          print('${userData['fullName'].toString()} is ${distance.round()}km away');
          if (distance.round() <= kilometres) {
            print("${distance.round()} < $kilometres");
            print('${userData['fullName'].toString()} is $userAge >= ${age.first} && <= ${age.last}');
            if ((userAge >= age.first - 1 && userAge <= age.last) || age.first == userAge) {
              final userModal = UserModel.fromJson(userData);
              userModals.add(userModal);
            }
          }
        }

        return userModals;
      }
    }

    snapshot = await query.get();

    return snapshot.docs.map<UserModel>((DocumentSnapshot e) {
      return UserModel.fromJson(e.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<String?> getDiscoverUserSetting(String uid) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.docs.isNotEmpty) {
      final userData = data.docs.first.data();
      final requestToShow = userData['requestToShow'];
      return requestToShow;
    } else {
      print("not found");
    }
  }

  Future<void> updatePosition(List<String> position) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'position': [position.last, position.first]
      });
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }

  Future<void> updateRequestToShow(String requestToShow) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'requestToShow': requestToShow});
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
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

  Future<UserModel> getToken(String uid) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();
    return UserModel.fromJson(data.docs.first.data());
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
          final uploadTask =
              storageRef.child('images/$uid/$fileName').putFile(image);
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

  Future updateUser(UserModel user) async {
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

  Future<List<UserModel>> getListUserChat(String uid) async {
    List<String> listUid = [];
    List<UserModel> userList = [];
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
            UserModel user =
                UserModel.fromJson(doc.data() as Map<String, dynamic>);
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

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Bán kính trái đất trong kilômét

    // Đổi độ sang radian
    double lat1Rad = _toRadians(lat1);
    double lon1Rad = _toRadians(lon1);
    double lat2Rad = _toRadians(lat2);
    double lon2Rad = _toRadians(lon2);

    // Tính khoảng cách giữa các vị trí
    double deltaLat = lat2Rad - lat1Rad;
    double deltaLon = lon2Rad - lon1Rad;
    double a = pow(sin(deltaLat / 2), 2) +
        cos(lat1Rad) * cos(lat2Rad) * pow(sin(deltaLon / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
