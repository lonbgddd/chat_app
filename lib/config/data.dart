
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  final data = FirebaseFirestore.instance;

  DatabaseServices(this.uid);


  Future<UserModal> getUserInfo() async {
    return data
        .collection("users")
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((e) => UserModal.fromJson(e.data())).single);
  }

  Stream<UserModal> getUserInfoStream() {
  return data
      .collection("users")
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => UserModal.fromJson(doc.data())).single);
}
}
