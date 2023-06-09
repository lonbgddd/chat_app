import 'dart:io';
import 'dart:math';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../model/user_time.dart';

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

  Future<List<UserModel>> getSelectionUser(String uid) async {
    DocumentSnapshot currentUserSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    String requestToShow = currentUserSnapshot['requestToShow'] ?? '';
    List<String> userInterests =
        currentUserSnapshot['interestsList'].cast<String>() ?? [];

    QuerySnapshot snapshot;

    if (currentUserSnapshot['requestToShow'] != "Mọi người") {
      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('requestToShow', isEqualTo: requestToShow)
          .where('interestsList', arrayContainsAny: userInterests)
          .get();
    } else {
      snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('interestsList', arrayContainsAny: userInterests)
          .get();
    }

    List<UserModel> userList = [];

    for (var doc in snapshot.docs) {
      final userData = doc.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromJson(userData);
      if (user.uid != uid) {
        userList.add(user);
      }
    }

    return userList;
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

  Future<List<UserModel>> getUserHasFilterKm(
      String uid, String? gender, List<double> age, double kilometres) async {
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

      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
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

          print(
              '${userData['fullName'].toString()} is ${distance.round()}km away');
          if (distance.round() <= kilometres) {
            print("${distance.round()} < $kilometres");
            print(
                '${userData['fullName'].toString()} is $userAge >= ${age.first} && <= ${age.last}');
            if ((userAge >= age.first - 1 && userAge <= age.last) ||
                age.first == userAge) {
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

  Future<void> deleteImage(String imageUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(imageUrl);
    await ref.delete().then((_) {
      print('Image deleted successfully.');
    }).catchError((error) {
      print('Failed to delete image: $error');
    });
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

  Future<bool> checkUserExists(String? uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (snapshot.exists) {
        return true;
      }
    } catch (error) {
      print('Kiểm tra người dùng không thành công: $error');
    }
    return false;
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

  Future<void> updateUserTime(
      String uid, String chatRoomId, String time) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> userTimes = data['userTimes'];
        List<dynamic> list = [];
        for (dynamic index in userTimes) {
          UserTime userTime = UserTime.fromJson(index);
          if (userTime.uid == uid) {
            Map<String, dynamic> myObject = {'uid': uid, 'time': time};
            list.add(myObject);
          } else {
            list.add(index);
          }
        }
        await FirebaseFirestore.instance
            .collection("chatRoom")
            .doc(chatRoomId)
            .update({"userTimes": list, "time": time});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getUserTime(String uid, String chatRoomId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("chatRoom")
          .doc(chatRoomId)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<dynamic> userTimes = data['userTimes'];
        for (dynamic index in userTimes) {
          UserTime userTime = UserTime.fromJson(index);
          if (userTime.uid == uid) {
            return userTime.time;
          }
        }
      }
      return '';
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateAddressUser(String uid, String address) async {
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
