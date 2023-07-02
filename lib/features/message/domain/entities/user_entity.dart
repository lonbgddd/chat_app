import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? email;
  final String? phone;
  final String? fullName;
  final String? birthday;
  final String? avatar;
  final String? gender;
  final String? requestToShow;
  final String? datingPurpose;
  final String? school;
  final String? introduceYourself;
  final List<String>? followersList;
  final List<String>? photoList;
  final List<String>? interestsList;
  final List<String>? fluentLanguageList;
  final bool? isHighlighted;
  final String? highlightTime;
  final List<String>? sexualOrientationList;
  final String? company;
  final String? currentAddress;
  final String? activeStatus;
  final String? token;

  //BasicInfoUser
  final String? zodiac;
  final String? academicLever;
  final String? communicateStyle;
  final String? languageOfLove;
  final String? familyStyle;
  final String? personalityType;

  //StyleOfLifeUser
  final String? myPet;
  final String? drinkingStatus;
  final String? smokingStatus;
  final String? sportsStatus;
  final String? eatingStatus;
  final String? socialNetworkStatus;
  final String? sleepingHabits;

  UserEntity(
      {
        required this.uid,
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
        this.isHighlighted,
        this.highlightTime,
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
        this.sleepingHabits
      });

  @override
  // TODO: implement props
  List<Object?> get props => [
        uid,
        email,
        phone,
        fullName,
        birthday,
        avatar,
        gender,
        datingPurpose,
        school,
        introduceYourself,
        followersList,
        photoList,
        interestsList,
        fluentLanguageList,
        sexualOrientationList,
        company,
        currentAddress,
        activeStatus,
        token,
        zodiac,
        academicLever,
        communicateStyle,
        languageOfLove,
        familyStyle,
        personalityType,
        myPet,
        drinkingStatus,
        smokingStatus,
        sportsStatus,
        eatingStatus,
        socialNetworkStatus,
        sleepingHabits
      ];
}
