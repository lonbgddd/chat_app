import 'dart:math';

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
    'Hoạt động ngoài trời','Giày Sneaker','Game Online','Rượu bia','Đạp xe','Karaoke','Phim ngôn tình','Phim kinh dị',
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
}
