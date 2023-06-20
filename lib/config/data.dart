import 'package:chat_app/model/basic_info_user.dart';
import 'package:chat_app/model/style_of_life_user.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  final data = FirebaseFirestore.instance;

  DatabaseServices(this.uid);
  // Future saveUserByEmailAndName(String email, String avatar, String uid,
  //     String name, String sex, String year,String bio,String token) async {
  //   data.collection('users').doc(uid).set(User(
  //       email: email,
  //       fullName: name,
  //       biography: bio,
  //       status:'online',
  //       token: token,
  //       avatar: avatar,
  //       uid: uid,
  //       gender: sex,
  //       birthday: year,
  //       post: [], interests: []).toJson(),
  //   );
  // }

  Future saveUserByEmailAndName(String email, String avatar, String uid,
      String name, String sex, String year, String bio,BasicInfoUser basicInfoUser,  StyleOfLifeUser styleOfLifeUser) async {
    data.collection('users').doc(uid).set(
          User(
              email: email,
              fullName: name,
              introduceYourself: bio,
              avatar: avatar,
              uid: uid,
              token: '',
              activeStatus: 'online',
              gender: sex,
              birthday: year,
              post: [],
              interestsList: [],
              phone: '',
              school: '',
              datingPurpose: '',
              company: '',
              currentAddress: '',
              photoList: [],
              fluentLanguageList: [],
              sexualOrientationList: [],
              styleOfLifeUser: styleOfLifeUser,
              basicInfoUser: basicInfoUser,
          ).toJson(),
        );
  }

  Future<User> getUserInfors() async {
    return data
        .collection("users")
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.map((e) => User.fromJson(e.data())).single);
  }

  Stream<User> getUserInforsStream() {
  return data
      .collection("users")
      .where('uid', isEqualTo: uid)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).single);
}
}
