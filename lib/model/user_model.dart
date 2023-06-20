// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/model/basic_info_user.dart';
import 'package:chat_app/model/style_of_life_user.dart';
UserModal userFromJson(String str) => UserModal.fromJson(json.decode(str));
String userToJson(UserModal data) => json.encode(data.toJson());

class UserModal {
  String uid;
  String email;
  String phone;
  String fullName;
  String birthday;
  String avatar;
  String gender;
  String datingPurpose;
  String school;
  String introduceYourself;
  List<String> post;
  List<String> photoList;
  List<String> interestsList;
  List<String> fluentLanguageList;
  List<String> sexualOrientationList;
  BasicInfoUser basicInfoUser;
  StyleOfLifeUser styleOfLifeUser;
  String company;
  String currentAddress;
  String activeStatus;
  String token;


  UserModal({
      required this.uid,
      required this.email,
      required this.phone,
      required this.fullName,
      required this.birthday,
      required this.avatar,
      required this.gender,
      required this.datingPurpose,
      required this.school,
      required this.introduceYourself,
      required this.post,
      required this.photoList,
      required this.interestsList,
      required this.fluentLanguageList,
      required this.sexualOrientationList,
      required this.basicInfoUser,
      required this.styleOfLifeUser,
      required this.company,
      required this.currentAddress,
      required this.activeStatus,
      required this.token});

  factory UserModal.fromJson(Map<String, dynamic> json) => UserModal(
    uid: json["uid"],
    email: json["email"],
    phone: json["phone"],
    fullName: json["fullName"],
    birthday: json["birthday"],
    avatar: json["avatar"],
    gender: json["gender"],
    datingPurpose: json["datingPurpose"],
    school: json["school"],
    introduceYourself: json["introduceYourself"],
    post: List<String>.from(json["post"].map((x) => x)),
    photoList: List<String>.from(json["photoList"].map((x) => x)),
    interestsList: List<String>.from(json["interestsList"].map((x) => x)),
    fluentLanguageList: List<String>.from(json["fluentLanguageList"].map((x) => x)),
    sexualOrientationList: List<String>.from(json["sexualOrientationList"].map((x) => x)),
    basicInfoUser: BasicInfoUser.fromJson(json["basicInformation"]),
    styleOfLifeUser: StyleOfLifeUser.fromJson(json["styleOfLifeUser"]),
    company: json["company"],
    currentAddress: json["currentAddress"],
    activeStatus: json["activeStatus"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "phone": phone,
        "fullName": fullName,
        "birthday": birthday,
        "avatar": avatar,
        "gender": gender,
        "datingPurpose": datingPurpose,
        "school": school,
        "introduceYourself": introduceYourself,
        "post": List<String>.from(post.map((x) => x)),
        "photoList": List<String>.from(photoList.map((x) => x)),
        "interestsList": List<String>.from(interestsList.map((x) => x)),
        "fluentLanguageList": List<String>.from(fluentLanguageList.map((x) => x)),
        "sexualOrientationList": List<String>.from(sexualOrientationList.map((x) => x)),
        "basicInfoUser": basicInfoUser.toJson(),
        "styleOfLifeUser": styleOfLifeUser.toJson(),
        "company": company,
        "currentAddress": currentAddress,
        "activeStatus": activeStatus,
        "token": token,
      };
}
