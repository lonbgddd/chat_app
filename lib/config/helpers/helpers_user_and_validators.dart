import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_assets.dart';

class HelpersUserAndValidators {


  static List<String> getItemFromListIndex(BuildContext context,List<String> stringList, List<int> indexes) {
    List<String> list = [];
    for (int index in indexes) {
      if (index >= 0 && index < stringList.length) {
        list.add(stringList[index]);
      }
    }
    return list;
  }

  static String getItemFromIndex(BuildContext context,List<String> stringList, int index) {
    if (index >= 0 && index < stringList.length) {
      return stringList[index];
    }
    return '';
  }


  static  List<String> sexualOrientationList (BuildContext context){
    final appLocal =  AppLocalizations.of(context);
    return [
      appLocal.straight, appLocal.gay, appLocal.lesbian,
      appLocal.bisexual,appLocal.ansexual,appLocal.demissexual,
      appLocal.pansexual,appLocal.transgender,appLocal.uncertain
    ];
  }


  static List<String> datingPurposeList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);

    List<String> list =  [
      appLocal.lover, appLocal.longTermDating, appLocal.anything,
      appLocal.casualRelationship,appLocal.newFriends,appLocal.notSureYet,
    ];
    return list;
  }




  static List<String> interestsList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    return [
      appLocal.shopping, appLocal.football, appLocal.tableTennis, appLocal.arteExhibitions,
      appLocal.tikTok,appLocal.eSports,appLocal.parties,appLocal.cosplay,appLocal.cars,appLocal.modernMusic,
      appLocal.classicalMusic,appLocal.fashion,appLocal.motorcycles,appLocal.selfCare,appLocal.netflix,appLocal.culinary,
      appLocal.photography,appLocal.archery,appLocal.bubbleTea,appLocal.sneakers,appLocal.onlineGaming,
      appLocal.wineAndBeer,appLocal.cycling,appLocal.karaoke,appLocal.romanticMovies,appLocal.horrorMovies,
      appLocal.camping, appLocal.surfing, appLocal.writingBlogs, appLocal.mountainClimbing, appLocal.instagram,
      appLocal.puzzles, appLocal.literature, appLocal.playingDrums,appLocal.realEstate,appLocal.entrepreneurship,
    ];
  }



  static List<String> emojiDatingPurposeList = [
    AppAssets.emojiLoveArrow,
    AppAssets.emojiInLove,
    AppAssets.emojiWine,
    AppAssets.emojiPartyPopper,
    AppAssets.emojiWavingHand,
    AppAssets.emojiThinking,
  ];

  static List<Color> colorBgPurposeList = [
    Color.fromRGBO(255, 229, 236, 1.0),
    Color.fromRGBO(255, 235, 235, 1.0),
    Color.fromRGBO(241, 240, 215, 1.0),
    Color.fromRGBO(228, 244, 220, 1.0),
    Color.fromRGBO(217, 241, 221, 1.0),
    Color.fromRGBO(223, 240, 244, 1.0),
  ];
  static List<Color> colorTitlePurposeList = [
    Color.fromRGBO(229, 42, 121, 1.0),
    Color.fromRGBO(193, 35, 35, 1.0),
    Color.fromRGBO(188, 159, 30, 1.0),
    Color.fromRGBO(47, 120, 10, 1.0),
    Color.fromRGBO(26, 179, 52, 1.0),
    Color.fromRGBO(10, 126, 155, 1.0),
  ];

  static List<String> zodiacList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.capricorn, appLocal.aquarius, appLocal.pisces,
      appLocal.aries, appLocal.taurus, appLocal.gemini, appLocal.cancer,
      appLocal.leo, appLocal.virgo,appLocal.libra,appLocal.scorpio,appLocal.sagittarius,
    ];
    return list;
  }


  static List<String> academicLeverList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.bachelor, appLocal.currentlyInCollege, appLocal.highSchool,
      appLocal.doctorate, appLocal.postgraduateStudies, appLocal.masterDegree, appLocal.vocationalSchool,
    ];
    return list;
  }

  static List<String> personalityTypeList = [
    'INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP',
    'ISTJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP'
  ];

  static List<String> familyStyleList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.familyStyle1, appLocal.familyStyle2, appLocal.familyStyle3,
      appLocal.familyStyle4, appLocal.familyStyle5
    ];
    return list;
  }

  static List<String> communicateStyleList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.communicateStyle1, appLocal.communicateStyle2, appLocal.communicateStyle3,
      appLocal.communicateStyle4, appLocal.communicateStyle5
    ];
    return list;
  }

  static List<String> languageOfLoveList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.languageOfLove1, appLocal.languageOfLove2, appLocal.languageOfLove3,
      appLocal.languageOfLove4, appLocal.languageOfLove5,
    ];
    return list;
  }

  static List<String> myPetList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.dog, appLocal.cat, appLocal.reptile, appLocal.amphibian, appLocal.bird,
      appLocal.fish,appLocal.turtle,appLocal.hamster,appLocal.rabbit,appLocal.likeButDontOwnPets,appLocal.dontOwnPets,
      appLocal.allTypesOfPets,appLocal.interestedInOwningPet,appLocal.allergicToAnimals

    ];
    return list;
  }




  static List<String> drinkingStatusList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.drinkingStatus1, appLocal.drinkingStatus2, appLocal.drinkingStatus3,
      appLocal.drinkingStatus4, appLocal.drinkingStatus5,appLocal.drinkingStatus6,
    ];
    return list;
  }


  static List<String> smokingStatusList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.smokingStatus1, appLocal.smokingStatus2, appLocal.smokingStatus3,
      appLocal.smokingStatus4, appLocal.smokingStatus5
    ];
    return list;
  }

  static List<String> sportsStatusList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.sportsStatus1, appLocal.sportsStatus2, appLocal.sportsStatus3,
      appLocal.sportsStatus4
    ];
    return list;
  }

  static List<String> eatingStatusList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.eatingStatus1, appLocal.eatingStatus2, appLocal.eatingStatus3,
      appLocal.eatingStatus4,appLocal.eatingStatus5,appLocal.eatingStatus6,appLocal.eatingStatus7
    ];
    return list;
  }

  static List<String> socialNetworkStatusList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.socialNetworkStatus1, appLocal.socialNetworkStatus2, appLocal.socialNetworkStatus3,
      appLocal.socialNetworkStatus4
    ];
    return list;
  }

  static List<String> sleepingHabitsStatusList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      appLocal.sleepingHabitsStatus1, appLocal.sleepingHabitsStatus2, appLocal.sleepingHabitsStatus3,
    ];
    return list;
  }


  static List<String> genderList = ['Nam', 'Nữ', 'Khác'];


  static List<String> highlightAppbarTitleList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
      '', appLocal.highlightAppbarTitle1, appLocal.highlightAppbarTitle2,
    ];
    return list;
  }

  static List<String> highlightPriceList = ['150.000', '300.000', '500.000'];

  static List<String> highlightTitleTimeList (BuildContext context) {
    final appLocal =  AppLocalizations.of(context);
    List<String> list =  [
       appLocal.highlightTime10, appLocal.highlightTime20, appLocal.highlightTime30,
    ];
    return list;
  }
  static List<int> highlightTimeList = [5, 10, 15];


  static List<String> basicInfoUserList(BuildContext context,UserModel userModel) {
    List<String> list = [
      getItemFromIndex(context, zodiacList(context), userModel.zodiac!),
      getItemFromIndex(context, academicLeverList(context), userModel.academicLever!),
      getItemFromIndex(context, languageOfLoveList(context), userModel.languageOfLove!),
      getItemFromIndex(context, familyStyleList(context), userModel.familyStyle!),
      getItemFromIndex(context, communicateStyleList(context), userModel.communicateStyle!),
      userModel.personalityType.toString(),
    ];
    return list;
  }

  static List<String> styleOfLifeUserList(BuildContext context, UserModel userModel) {
    List<String> list = [
      getItemFromIndex(context, myPetList(context), userModel.myPet!),
      getItemFromIndex(context, drinkingStatusList(context), userModel.drinkingStatus!),
      getItemFromIndex(context, smokingStatusList(context), userModel.smokingStatus!),
      getItemFromIndex(context, sportsStatusList(context), userModel.sportsStatus!),
      getItemFromIndex(context, eatingStatusList(context), userModel.eatingStatus!),
      getItemFromIndex(context, socialNetworkStatusList(context), userModel.socialNetworkStatus!),
      getItemFromIndex(context, sleepingHabitsStatusList(context), userModel.sleepingHabits!),
    ];
    return list;
  }

  static bool isListNotEmpty(List<String> list) {
    return !list.every((element) => element == "");
  }

  static List<Map<String, dynamic>> countryCodes = [
    {'display': 'VN', 'value': '+84'},
    {'display': 'US', 'value': '+1'},
    {'display': 'UK', 'value': '+44'},
  ];

  static bool isStringNotEmpty(String input) {
    if (input != null && input.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    String pattern =
        r'^(0|84)(2(0[3-9]|1[0-6|8|9]|2[0-2|5-9]|3[2-9]|4[0-9]|5[1|2|4-9]|6[0-3|9]|7[0-7]|8[0-9]|9[0-4|6|7|9])|3[2-9]|5[5|6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])([0-9]{7})$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phoneNumber);
  }


  static String isValidBirthday(String day, String month, String year) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    if (day.isEmpty || month.isEmpty || year.isEmpty) {
      return 'Hãy nhập đủ ngày tháng năm sinh';
    } else if (int.parse(day) < 0 && int.parse(day) > 31) {
      return 'Ngày sinh đã vượt quá! Hãy nhập lại';
    } else if (int.parse(month) < 0 && int.parse(day) > 12) {
      return 'Tháng sinh đã vượt quá! Hãy nhập lại';
    } else if (int.parse(year) < 1900 && int.parse(year) > currentYear) {
      return 'Năm sinh đã vượt quá! Hãy nhập lại';
    }
    return 'Hãy nhập đủ dữ liệu.';
  }

  static String extractCity(String input, String separator, int indexFromEnd) {
    int lastIndex = input.lastIndexOf(separator);
    if (lastIndex != -1) {
      int startIndex = input.lastIndexOf(separator, lastIndex - 1);
      if (startIndex != -1) {
        startIndex += separator.length;
        if (startIndex < lastIndex) {
          String extractedSubstring =
              input.substring(startIndex, lastIndex).trim();
          return extractedSubstring;
        }
      }
    }
    return '';
  }
}
