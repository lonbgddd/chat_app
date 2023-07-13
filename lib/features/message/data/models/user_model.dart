import '../../domain/entities/user_entity.dart';

class MyUserModal extends UserEntity {

  MyUserModal({
    String? uid,
    String? email,
    String? phone,
    String? fullName,
    String? birthday,
    String? avatar,
    String? gender,
    String? requestToShow,
    int? datingPurpose,
    String? school,
    String? introduceYourself,
    List<String>? followersList,
    List<String>? photoList,
    List<int>? interestsList,
    List<String>? fluentLanguageList,
     bool? isHighlighted,
     String? highlightTime,
    List<int>? sexualOrientationList,
    String? company,
    String? currentAddress,
    String? activeStatus,
    String? token,

    //BasicInfoUser
    int? zodiac,
    int? academicLever,
    int? communicateStyle,
    int? languageOfLove,
    int? familyStyle,
    String? personalityType,

    //StyleOfLifeUser
    int? myPet,
    int? drinkingStatus,
    int? smokingStatus,
    int? sportsStatus,
    int? eatingStatus,
    int? socialNetworkStatus,
    int? sleepingHabits,


  }) : super(
          uid: uid,
          email: email,
          phone: phone,
          fullName: fullName,
          birthday: birthday,
          avatar: avatar,
          gender: gender,
          requestToShow: requestToShow,
          datingPurpose: datingPurpose,
          school: school,
          introduceYourself: introduceYourself,
          followersList: followersList,
          photoList: photoList,
          interestsList: interestsList,
          fluentLanguageList: fluentLanguageList,
          isHighlighted: isHighlighted,
          highlightTime: highlightTime,
          sexualOrientationList: sexualOrientationList,
          company: company,
          currentAddress: currentAddress,
          activeStatus: activeStatus,
          token: token,

          //BasicInfoUser
          zodiac: zodiac,
          academicLever: academicLever,
          communicateStyle: communicateStyle,
          languageOfLove: languageOfLove,
          familyStyle: familyStyle,
          personalityType: personalityType,

          //StyleOfLifeUser
          myPet: myPet,
          drinkingStatus: drinkingStatus,
          smokingStatus: smokingStatus,
          sportsStatus: sportsStatus,
          eatingStatus: eatingStatus,
          socialNetworkStatus: socialNetworkStatus,
          sleepingHabits: sleepingHabits,
        );

  factory MyUserModal.fromJson(Map<String, dynamic> json) => MyUserModal(
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
    "followersList": List<String>.from(followersList!.map((x) => x)) ?? [],
    "photoList": List<String>.from(photoList!.map((x) => x)) ?? [],
    "interestsList": List<int>.from(interestsList!.map((x) => x)) ?? [],
    "fluentLanguageList": [],
    "sexualOrientationList":
    List<int>.from(sexualOrientationList!.map((x) => x)) ?? [],
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
