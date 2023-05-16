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

  User({
    required this.email,
    required this.name,
    required this.avatar,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "avatar": avatar,
        "uid": uid,
      };
}
