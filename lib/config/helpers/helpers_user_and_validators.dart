import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_assets.dart';

class HelpersUserAndValidators {
  static List<String> sexualOrientationList = [
    'Heterosexual',
    'Homosexual',
    'Lesbian',
    'Bisexual',
    'Asexual',
    'Pansexual',
    'Demisexual',
    'Queer',
    'Undefined or unsure about orientation',
  ];

  static List<String> datingPurposeList = [
    'Long-term relationship',
    'Casual dating',
    'Open to anything',
    'Non-committed relationship',
    'Making new friends',
    'Not sure yet',
  ];

  static List<String> interestsList = [
    'Shopping',
    'Football',
    'Table tennis',
    'Art exhibitions',
    'TikTok',
    'E-sports',
    'Parties',
    'Cosplay',
    'Cars',
    'Modern music',
    'Classical music',
    'Fashion',
    'Motorcycles',
    'Self-care',
    'Netflix',
    'Cuisine',
    'Photography',
    'Archery',
    'Bubble tea',
    'Outdoor activities',
    'Sneakers',
    'Online gaming',
    'Alcoholic beverages',
    'Cycling',
    'Karaoke',
    'Romantic movies',
    'Horror movies',
    'Camping',
    'Surfing',
    'Writing blogs',
    'Mountain climbing',
    'Instagram',
    'Puzzles',
    'Literature',
    'Playing drums',
    'Real estate',
    'Entrepreneurship'
  ];

  static List<String> emojiDatingPurposeList = [
    AppAssets.emojiLoveArrow,
    AppAssets.emojiInLove,
    AppAssets.emojiWine,
    AppAssets.emojiPartyPopper,
    AppAssets.emojiWavingHand,
    AppAssets.emojiThinking,
  ];

  static List<Map<String, dynamic>> countryCodes = [
    {'display': 'VN', 'value': '+84'},
    {'display': 'US', 'value': '+1'},
    {'display': 'UK', 'value': '+44'},
  ];

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
      return 'Please enter your date of birth';
    } else if (int.parse(day) < 0 || int.parse(day) > 31) {
      return 'Invalid day! Please enter a valid day';
    } else if (int.parse(month) < 0 || int.parse(month) > 12) {
      return 'Invalid month! Please enter a valid month';
    } else if (int.parse(year) < 1900 || int.parse(year) > currentYear) {
      return 'Invalid year! Please enter a valid year';
    }
    return 'Please enter all the required information';
  }

}
