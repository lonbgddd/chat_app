// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String email;
  String fullName;
  String avatar;
  String uid;
  List<String> post;
  List<String> interests;
  String gender;
  String biography;
  String birthday;
  String status;
  String token;

  User(
      {required this.email,
      required this.status,
      required this.token,
      required this.biography,
      required this.fullName,
      required this.avatar,
      required this.uid,
      required this.post,
      required this.interests,
      required this.gender,
      required this.birthday});

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        email: json["email"],
        biography: json["biography"],
        birthday: json["birthday"],
        fullName: json["fullName"],
        gender: json["gender"],
        interests: List<String>.from(json["interests"].map((x) => x)),
        post: List<String>.from(json["post"].map((x) => x)),
        token: json["token"],
        uid: json["uid"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "status": status,
        "token": token,
        "fullName": fullName,
        "biography": biography,
        "avatar": avatar,
        "uid": uid,
        "post": List<String>.from(post.map((x) => x)),
        "interests": List<String>.from(interests.map((x) => x)),
        "gender": gender,
        "birthday": birthday,
      };
}
