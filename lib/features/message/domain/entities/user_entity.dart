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
  final int? datingPurpose;
  final String? school;
  final String? introduceYourself;
  final List<String>? followersList;
  final List<String>? photoList;
  final List<int>? interestsList;
  final List<String>? fluentLanguageList;
  final bool? isHighlighted;
  final String? highlightTime;
  final List<int>? sexualOrientationList;
  final String? company;
  final String? currentAddress;
  final String? activeStatus;
  final String? token;

  //BasicInfoUser
  final int? zodiac;
  final int? academicLever;
  final int? communicateStyle;
  final int? languageOfLove;
  final  int? familyStyle;
  final String? personalityType;

  //StyleOfLifeUser
  final  int? myPet;
  final int? drinkingStatus;
  final int? smokingStatus;
  final int? sportsStatus;
  final int? eatingStatus;
  final int? socialNetworkStatus;
  final int? sleepingHabits;

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
