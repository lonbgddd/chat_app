import 'dart:math';

import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_assets.dart';

class HelpersUserAndValidators {
  static  List<String> sexualOrientationList = [
    'Dị tính',
    'Đồng tính',
    'Đồng tính nữ',
    'Song tính',
    'Vô tính',
    'Á tính',
    'Toàn tính',
    'Queer',
    'Chưa xác định rõ khuynh hướng',
  ];

  static  List<String> datingPurposeList = [
    'Người yêu',
    'Bạn hẹn hò lâu dài',
    'Bất kì điều gì có thể',
    'Quan hệ không ràng buộc',
    'Những người bạn mới',
    'Mình cũng chưa rõ lắm',
  ];

  static  List<String> interestsList = [
    'Mua sắm', 'Đá bóng','Bóng bàn','Triễn lãm nghệ thuật','TikTok','Thể thao điện tử','Tiệc tùng','Cosplay','Xe hơi','Nhạc hiện đại',
    'Nhạc cổ điển','Thời trang','Xe máy','Chăm sóc bản thân','Netflix','Ẩm thực','Nhiếp ảnh','Bắn cung','Trà sữa',
    ' ','Giày Sneaker','Game Online','Rượu bia','Đạp xe','Karaoke','Phim ngôn tình','Phim kinh dị',
    'Cắm trại','Lướt sóng','Viết blog','Leo núi','Instagram','Giải đố','Văn học','Chơi trống','Bất động sản','Khởi nghiệp'
  ];

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

  static  List<String> zodiacList = [
    'Ma kết', 'Bảo bình', 'Song ngư',
    'Bạch dương','Kim ngưu', 'Song tử', 'Cự giải', 'Sư Tử',
    'Sư tử','Thiên bình','Bọ cạp','Nhân mã'
  ];

  static  List<String> academicLeverList = [
    'Cử nhân', 'Đang học đại học',' Trung học phổ thông',
    'Tiến sĩ', 'Đang học sau đại học', 'Thạc sĩ', 'Trường dạy nghề'
  ];
  static  List<String> personalityTypeList = [
    'INTJ', 'INTP','ENTJ','ENTP','INFJ','INFP','ENFJ','ENFP','ISTJ','ESTJ','ESFJ',
    'ISTP','ISFP','ESTP','ESFP'
  ];
  static  List<String> familyStyleList = [
    'Mình muốn có con', 'Mình không muốn có con','Mình có con rồi và muốn có thêm',
    'Mình có con rồi và không muốn có thêm', 'Vẫn chưa chắc chắn',
  ];

  static  List<String> communicateStyleList = [
   'Nghiện nhắn tin','Thích gọi điện','Thích goi video','Ít nhắn tin','Thích gặp mặt trực tiếp'
  ];
  static  List<String> languageOfLoveList = [
    'Những hành động tinh tế', 'Những món quà','Những cử chỉ âu yếm','Những lời khen',
    'Thời gian bên nhau'
  ];


  static  List<String> myPetList = [
    'Chó', 'Mèo','Bò sát','Động vật lưỡng cư','Loài chim','Cá','Rùa','Hamster','Thỏ',
    'Thích nhưng không nuôi','Không nuôi thú cưng','Tất cả các loại thú cưng','Muốn nuôi thứ cưng','Dị ứng với động vật'
  ];

  static  List<String> drinkingStatusList = [
    'Không dành cho mình','Luôn tỉnh táo','Uống có trách nhiệm','Chỉ những dịp đặc biệt',
    'Uống giao lưu vào cuối tuần', 'Hầu như mỗi tối'
  ];

  static  List<String> smokingStatusList = [
    'Hút thuốc với bạn bè','Hút thuốc khi nhậu','Không hút thuốc',
    'Hút thuốc thường xuyên','Đang cố gắng bỏ'
  ];
  static  List<String> sportsStatusList = [
    'Hàng ngày','Thường xuyên','Thỉnh thoảng','Không tập'
  ];
  static  List<String> eatingStatusList = [
   'Ăn chay','Ăn thuần chay','Chỉ ăn hải sản và rau củ','Chỉ ăn thịt','Không ăn kiêng', 'Ăn kiêng','Khác'
  ];

  static  List<String> socialNetworkStatusList = [
    'Influence','Hoạt động tích cực','Khôgn dùng mạng','Lướt dạo âm thầm'
  ];
  static  List<String> sleepingHabitsStatusList = [
   'Dậy sớm','Cú đêm', 'Giờ giấc linh hoạt'
  ];




  static List<String> basicInfoUserList (UserModel userModel){
    List<String> list = [
      userModel.zodiac.toString(),
      userModel.academicLever.toString(),
      userModel.communicateStyle.toString(),
      userModel.languageOfLove.toString(),
      userModel.familyStyle.toString(),
      userModel.personalityType.toString(),
    ];
    return list;
  }


  static List<String> styleOfLifeUserList (UserModel userModel){
    List<String> list = [
      userModel.myPet.toString(),
      userModel.drinkingStatus.toString(),
      userModel.smokingStatus.toString(),
      userModel.sportsStatus.toString(),
      userModel.eatingStatus.toString(),
      userModel.socialNetworkStatus.toString(),
      userModel.sleepingHabits.toString(),
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
          String extractedSubstring = input.substring(startIndex, lastIndex).trim();
          return extractedSubstring;
        }
      }
    }
    return '';
  }



}
