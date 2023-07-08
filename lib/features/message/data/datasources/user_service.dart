import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  const UserService();

  Future<MyUserModal> getUserInformation(String uid) async {
    try {
      return FirebaseFirestore.instance.collection("users").doc(uid).get().then((doc) async {
        List<dynamic> listUid = doc['followersList'];
        Map<String, dynamic>? data = doc.data();
        await FirebaseFirestore.instance.collection("chatRoom")
            .where('users', arrayContains: uid)
            .get().then((snapshot) {
              for(var doc in snapshot.docs){
                List<dynamic> users = doc['users'];
                for (var uidUser in users) {
                  if (uidUser != uid) {
                    listUid.remove(uidUser);
                  }
                }
              }
        });
        data?['followersList'] = listUid;
        return MyUserModal.fromJson(data!);
    });
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<MyUserModal> getInfoUser(String uid) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .snapshots()
          .map((documentSnapshot) {
        return MyUserModal.fromJson(documentSnapshot.data()!);
      });
    } catch (e) {
      throw Exception('$e');
    }
  }

}
