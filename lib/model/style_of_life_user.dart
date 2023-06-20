// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
StyleOfLifeUser userFromJson(String str) => StyleOfLifeUser.fromJson(json.decode(str));
String userToJson(StyleOfLifeUser data) => json.encode(data.toJson());

class StyleOfLifeUser {
  String myPet;
  String drinkingStatus;
  String smokingStatus;
  String sportsStatus;
  String eatingStatus;
  String socialNetworkStatus;
  String sleepingHabits;

  StyleOfLifeUser(
      {required this.myPet,
      required this.drinkingStatus,
      required this.smokingStatus,
      required this.sportsStatus,
      required this.eatingStatus,
      required this.socialNetworkStatus,
      required this.sleepingHabits,
  });

  factory StyleOfLifeUser.fromJson(Map<String, dynamic> json) => StyleOfLifeUser(
    myPet: json["myPet"],
    drinkingStatus: json["drinkingStatus"],
    smokingStatus: json["smokingStatus"],
    sportsStatus: json["sportsStatus"],
    eatingStatus: json["eatingStatus"],
    socialNetworkStatus: json["socialNetworkStatus"],
    sleepingHabits: json["sleepingHabits"],
      );

  Map<String, dynamic> toJson() => {
        "myPet": myPet,
        "drinkingStatus": drinkingStatus,
        "smokingStatus": smokingStatus,
        "sportsStatus": sportsStatus,
        "eatingStatus": eatingStatus,
        "socialNetworkStatus": socialNetworkStatus,
        "sleepingHabits": sleepingHabits,
      };
}
