
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  const UserService();

  Future<UserModal> getUserInformation(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((doc) => UserModal.fromJson(doc.data() as Map<String, dynamic>));
  }
}
