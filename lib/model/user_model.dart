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
  String datingPurpose;
  String? school;
  String? introduceYourself;
  List<String> followersList;
  List<String> photoList;
  List<String> interestsList;
  List<String>? fluentLanguageList;
  List<String> sexualOrientationList;
  List<String> position;
  bool isHighlighted;
  String highlightTime;
  String? company;
  String? currentAddress;
  String? activeStatus;
  String token;

  //BasicInfoUser
  String? zodiac;
  String? academicLever;
  String? communicateStyle;
  String? languageOfLove;
  String? familyStyle;
  String? personalityType;

  //StyleOfLifeUser
  String? myPet;
  String? drinkingStatus;
  String? smokingStatus;
  String? sportsStatus;
  String? eatingStatus;
  String? socialNetworkStatus;
  String? sleepingHabits;

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
    datingPurpose: json["datingPurpose"] ?? '',
    school: json["school"] ?? '',
    introduceYourself: json["introduceYourself"] ?? '',
    followersList:
    List<String>.from(json["followersList"].map((x) => x)) ?? [],
    photoList: List<String>.from(json["photoList"].map((x) => x)) ?? [],
    interestsList:
    List<String>.from(json["interestsList"].map((x) => x)) ?? [],
    fluentLanguageList:
    List<String>.from(json["fluentLanguageList"].map((x) => x)) ?? [],
    sexualOrientationList:
    List<String>.from(json["sexualOrientationList"].map((x) => x)) ??
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
    zodiac: json["zodiac"] ?? '',
    academicLever: json["academicLever"] ?? '',
    communicateStyle: json["communicateStyle"] ?? '',
    languageOfLove: json["languageOfLove"] ?? '',
    familyStyle: json["familyStyle"] ?? '',
    personalityType: json["personalityType"] ?? '',
    myPet: json["myPet"] ?? '',
    drinkingStatus: json["drinkingStatus"] ?? '',
    smokingStatus: json["smokingStatus"] ?? '',
    sportsStatus: json["sportsStatus"] ?? '',
    eatingStatus: json["eatingStatus"] ?? '',
    socialNetworkStatus: json["socialNetworkStatus"] ?? '',
    sleepingHabits: json["sleepingHabits"] ?? '',
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
    "datingPurpose": datingPurpose ?? '',
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
    "zodiac": zodiac ?? '',
    "academicLever": academicLever ?? '',
    "communicateStyle": communicateStyle ?? '',
    "languageOfLove": languageOfLove ?? '',
    "familyStyle": familyStyle ?? '',
    "personalityType": personalityType ?? '',
    "myPet": myPet ?? '',
    "drinkingStatus": drinkingStatus ?? '',
    "smokingStatus": smokingStatus ?? '',
    "sportsStatus": sportsStatus ?? '',
    "eatingStatus": eatingStatus ?? '',
    "socialNetworkStatus": socialNetworkStatus ?? '',
    "sleepingHabits": sleepingHabits ?? '',
  };
}
