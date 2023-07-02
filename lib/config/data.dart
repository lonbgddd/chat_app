import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  final data = FirebaseFirestore.instance;

  DatabaseServices(this.uid);

  Future<UserModel> getUserInfo() async {
    return data.collection("users").where('uid', isEqualTo: uid).get().then(
        (value) => value.docs.map((e) => UserModel.fromJson(e.data())).single);
  }

  Stream<UserModel> getUserInfoStream() {
    return data
        .collection("users")
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).single);
  }
}
