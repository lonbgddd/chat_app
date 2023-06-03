// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String email;
  String name;
  String avatar;
  String uid;
  List<String> post;
  String sex;
  String year;

  User(
      {required this.email,
      required this.name,
      required this.avatar,
      required this.uid,
      required this.post,
      required this.sex,
      required this.year});

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        uid: json["uid"],
        post: List<String>.from(json["post"].map((x) => x)),
        sex: json["sex"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "avatar": avatar,
        "uid": uid,
        "post": List<String>.from(post.map((x) => x)),
        "sex": sex,
        "year": year
      };
}
