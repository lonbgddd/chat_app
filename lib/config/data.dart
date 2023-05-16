import 'package:chat_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  final data = FirebaseFirestore.instance;

  DatabaseServices(this.uid);

  Future saveUserByEmailAndName(
      String email, String avatar, String uid, String name) async {
    data
        .collection('users')
        .doc(uid)
        .set(User(email: email, name: name, avatar: avatar, uid: uid).toJson());
  }
}
