import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));
String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String uid;
  String email;
  String phone;
  String fullName;
  String birthday;
  String avatar;
  String gender;
  String requestToShow;
  int datingPurpose;
  String? school;
  String? introduceYourself;
  List<String> followersList;
  List<String> photoList;
  List<int> interestsList;
  List<String>? fluentLanguageList;
  List<int> sexualOrientationList;

  List<String> position;
  bool isHighlighted;
  String highlightTime;
  String? company;
  String? currentAddress;
  String? activeStatus;
  String token;

  //BasicInfoUser
  int? zodiac;
  int? academicLever;
  int? communicateStyle;
  int? languageOfLove;
  int? familyStyle;
  String? personalityType;

  //StyleOfLifeUser
  int? myPet;
  int? drinkingStatus;
  int? smokingStatus;
  int? sportsStatus;
  int? eatingStatus;
  int? socialNetworkStatus;
  int? sleepingHabits;

  UserModel(
      {required this.uid,
        required this.position,
        required this.email,
        required this.phone,
        required this.fullName,
        required this.birthday,
        required this.avatar,
        required this.gender,
        required this.requestToShow,
        required this.datingPurpose,
        this.school,
        this.introduceYourself,
        required this.followersList,
        required this.photoList,
        required this.interestsList,
        required this.sexualOrientationList,
        this.fluentLanguageList,
        required this.isHighlighted,
        required this.highlightTime,
        this.company,
        this.currentAddress,
        this.activeStatus,
        required this.token,
        this.zodiac,
        this.academicLever,
        this.communicateStyle,
        this.languageOfLove,
        this.familyStyle,
        this.personalityType,
        this.myPet,
        this.drinkingStatus,
        this.smokingStatus,
        this.sportsStatus,
        this.eatingStatus,
        this.socialNetworkStatus,
        this.sleepingHabits});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
    fullName: json["fullName"] ?? '',
    birthday: json["birthday"] ?? '',
    avatar: json["avatar"] ?? '',
    gender: json["gender"] ?? '',
    requestToShow: json["requestToShow"] ?? '',
    datingPurpose: json["datingPurpose"] ?? -1,
    school: json["school"] ?? '',
    introduceYourself: json["introduceYourself"] ?? '',
    followersList:
    List<String>.from(json["followersList"].map((x) => x)) ?? [],
    photoList: List<String>.from(json["photoList"].map((x) => x)) ?? [],
    interestsList:
    List<int>.from(json["interestsList"].map((x) => x)) ?? [],
    fluentLanguageList:
    List<String>.from(json["fluentLanguageList"].map((x) => x)) ?? [],
    sexualOrientationList:
    List<int>.from(json["sexualOrientationList"].map((x) => x)) ??
        [],
    position:
    List<String>.from(json["position"].map((x) => x)) ??
        [],
    isHighlighted: json["isHighlighted"] ?? false,
    highlightTime: json["highlightTime"] ?? null,
    company: json["company"] ?? '',
    currentAddress: json["currentAddress"] ?? '',
    activeStatus: json["activeStatus"],
    token: json["token"],
    zodiac: json["zodiac"] ?? -1,
    academicLever: json["academicLever"] ??-1,
    communicateStyle: json["communicateStyle"] ??-1,
    languageOfLove: json["languageOfLove"] ?? -1,
    familyStyle: json["familyStyle"] ?? -1,
    personalityType: json["personalityType"] ?? '',
    myPet: json["myPet"] ?? -1,
    drinkingStatus: json["drinkingStatus"] ?? -1,
    smokingStatus: json["smokingStatus"] ?? -1,
    sportsStatus: json["sportsStatus"] ?? -1,
    eatingStatus: json["eatingStatus"] ?? -1,
    socialNetworkStatus: json["socialNetworkStatus"] ??-1,
    sleepingHabits: json["sleepingHabits"] ?? -1,
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "phone": phone ?? '',
    "fullName": fullName ?? '',
    "birthday": birthday ?? '',
    "avatar": avatar ?? '',
    "gender": gender ?? '',
    "requestToShow": requestToShow ?? '',
    "datingPurpose": datingPurpose ??  -1,
    "school": school ?? '',
    "introduceYourself": introduceYourself ?? '',
    "followersList": List<String>.from(followersList.map((x) => x)) ?? [],
    "photoList": List<String>.from(photoList.map((x) => x)) ?? [],
    "interestsList": List<String>.from(interestsList.map((x) => x)) ?? [],
    "position": List<String>.from(position.map((x) => x)) ?? [],
    "fluentLanguageList": [],
    "sexualOrientationList":
    List<String>.from(sexualOrientationList.map((x) => x)) ?? [],
    "isHighlighted": isHighlighted ?? false,
    "highlightTime": highlightTime ?? '',
    "company": company ?? '',
    "currentAddress": currentAddress ?? '',
    "activeStatus": activeStatus ?? '',
    "token": token ?? '',
    "zodiac": zodiac ?? -1,
    "academicLever": academicLever ?? -1,
    "communicateStyle": communicateStyle ?? -1,
    "languageOfLove": languageOfLove ??-1,
    "familyStyle": familyStyle ?? -1,
    "personalityType": personalityType ?? '',
    "myPet": myPet ?? -1,
    "drinkingStatus": drinkingStatus ?? -1,
    "smokingStatus": smokingStatus ?? -1,
    "sportsStatus": sportsStatus ?? -1,
    "eatingStatus": eatingStatus ?? -1,
    "socialNetworkStatus": socialNetworkStatus ?? -1,
    "sleepingHabits": sleepingHabits ?? -1,
  };
}
