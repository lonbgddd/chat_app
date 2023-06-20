// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';
BasicInfoUser userFromJson(String str) => BasicInfoUser.fromJson(json.decode(str));
String userToJson(BasicInfoUser data) => json.encode(data.toJson());


class BasicInfoUser {
  String zodiac;
  String academicLever;
  String communicateStyle;
  String languageOfLove;
  String familyStyle;
  String personalityType;

  BasicInfoUser(
      {required this.zodiac,
      required this.academicLever,
      required this.communicateStyle,
      required this.languageOfLove,
      required this.personalityType,
      required this.familyStyle,});

  factory BasicInfoUser.fromJson(Map<String, dynamic> json) => BasicInfoUser(
    zodiac: json["zodiac"],
    academicLever: json["academicLever"],
    communicateStyle: json["communicateStyle"],
    languageOfLove: json["languageOfLove"],
    personalityType: json["personalityType"],
    familyStyle: json["familyStyle"],
  );

  Map<String, dynamic> toJson() => {
        "zodiac": zodiac,
        "academicLever": academicLever,
        "communicateStyle": communicateStyle,
        "personalityType": personalityType,
        "languageOfLove": languageOfLove,
        "familyStyle": familyStyle,
      };
}
