import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  const UserService();

  Future<MyUserModal> getUserInformation(String uid) async {
    try {
      return FirebaseFirestore.instance.collection("users").doc(uid).get().then(
          (doc) => MyUserModal.fromJson(doc.data() as Map<String, dynamic>));
    } catch (e) {
      throw Exception(e);
    }
  }
}
