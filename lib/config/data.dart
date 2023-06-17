import 'package:chat_app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  final data = FirebaseFirestore.instance;

  DatabaseServices(this.uid);

  Future saveUserByEmailAndName(String email, String avatar, String uid,
      String name, String sex, String year,String bio) async {
    data.collection('users').doc(uid).set(User(
        email: email,
        fullName: name,
        biography: bio,
        avatar: avatar,
        uid: uid,
        gender: sex,
        birthday: year,
        post: [], interests: []).toJson(),
    );
  }

  Future<User> getUserInfors() async {
    return data
        .collection("users")
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((e) => User.fromJson(e.data())).single);
  }
}
