import 'dart:math';

import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../../model/user_time.dart';

class BinderWatch extends ChangeNotifier {
  List<UserModel> _listCard = [];
  List<UserModel> tempList = [];
  Offset _offset = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;
  String _selectedOption = 'Everyone';
  bool _showPeopleInRangeDistance = false;
  double _distancePreference = 2;
  bool _showPeopleInRangeAge = false;
  List<double> _currentAgeValue = [18, 22];

  String get selectedOption => _selectedOption;

  double get distancePreference => _distancePreference;

  List<double> get currentAgeValue => _currentAgeValue;

  bool get showPeopleInRangeDistance => _showPeopleInRangeDistance;

  bool get showPeopleInRangeAge => _showPeopleInRangeAge;
  Offset get position => _offset;

  bool get isDragging => _isDragging;
  Size _size = Size.zero;

  List<UserModel> get listCard => _listCard;

  void initData() {
    _listCard = [];
  }

  // Future<List<UserModel>> allUserBinder() async {
  //   try {
  //     final uid =
  //         await HelpersFunctions().getUserIdUserSharedPreference() as String;
  //     final users = await DatabaseMethods().getAllUser(uid);
  //     _listCard = users ?? [];
  //     print('List user card: ${_listCard.length}');
  //     return _listCard;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  void shuffleUsers(List<UserModel> users) {
    final random = Random();
    for (var i = users.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = users[i];
      users[i] = users[j];
      users[j] = temp;
    }
  }

  void setDistancePreference(double value) {
    _distancePreference = value;
    notifyListeners();
  }

  void setCurrentAgeValue(List<double> value) {
    _currentAgeValue = value;
    notifyListeners();
  }

  void setSwitchPeopleInRangeAge(bool option) {
    _showPeopleInRangeAge = option;
    notifyListeners();
  }

  void setSwitchPeopleInRangeDistance(bool option) {
    _showPeopleInRangeDistance = option;
    notifyListeners();
  }

  Future<void> initializeSelectedOption() async {
    try {
      _selectedOption = await discoverSetting() as String;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  void setSelectedOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }

  Future<void> updateRequestToShow() async {
    await DatabaseMethods().updateRequestToShow(_selectedOption);
  }

  Future<void> updatePositionUser(List<String> position) async {
    await DatabaseMethods().updatePosition(position);
  }

  Future<List<UserModel>> allUserBinder(String gender, List<double> age,
      bool isInDistanceRange, double kilometres) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      final List<UserModel> users;
      if (isInDistanceRange) {
        users = await DatabaseMethods()
            .getUserHasFilterKm(uid, gender, [age.first, age.last], kilometres);
      } else {
        users = await DatabaseMethods()
            .getUserHasFilter(uid, gender, [age.first, age.last]);
      }
      print('Your list has ${users.length} elements');
      _listCard = users ?? [];

      return _listCard;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> discoverSetting() async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      final users = await DatabaseMethods().getDiscoverUserSetting(uid);
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  double get angle => _angle;

  void setScreenSize(Size size) => _size = size;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _offset += details.delta;
    final x = _offset.dx;
    _angle = 45 * x / _size.width;
    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();
    final status = getStatus(focus: true);

    switch (status) {
      case StatusCard.like:
        like();
        break;
      case StatusCard.dislike:
        disLike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _offset = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  Future addFollow(String followId, String token) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      await DatabaseMethods().addFollow(uid, followId);
      String check = await DatabaseMethods().checkFollow(uid, followId);
      if (check == "follow") {
        List<String> users = [uid, followId];
        String chatRoomId = getChatRoomId(uid, followId);
        List<dynamic> userTimes = [
          UserTime(uid: uid, time: DateTime.now().toString()).toJson(),
          UserTime(uid: followId, time: DateTime.now().toString()).toJson()
        ];
        Map<String, dynamic> chatRoom = {
          "users": users,
          "chatRoomId": chatRoomId,
          "userTimes": userTimes
        };
        await FirebaseApi().sendPushMessage(
            title: 'Match',
            uid: uid,
            type: 'match',
            body: 'Bạn có một tương hợp mới nhớ kiểm tra',
            avatar: '',
            token: token);
        await DatabaseMethods().addChatRoom(chatRoom, chatRoomId);
      }

      return check;
    } catch (e) {
      throw Exception(e);
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "${b}_$a";
    } else {
      return "${a}_$b";
    }
  }

  double getStatusOpacity() {
    const detail = 100;
    final pos = max(_offset.dx.abs(), _offset.dy.abs());
    final opacity = pos / detail;
    return min(opacity, 1);
  }

  StatusCard? getStatus({bool focus = false}) {
    final x = _offset.dx;

    if (focus) {
      const delta = 100;
      if (x >= delta) {
        return StatusCard.like;
      } else if (x <= -delta) {
        return StatusCard.dislike;
      }
    } else {
      const delta = 20;
      if (x >= delta) {
        return StatusCard.like;
      } else if (x <= -delta) {
        return StatusCard.dislike;
      }
    }
  }

  void like() {
    _angle = 20;
    _offset += Offset(2 * _size.width, 0);
    addFollow(_listCard.first.uid, _listCard.first.token);
    _nextCard();

    notifyListeners();
  }

  void disLike() {
    _angle = -20;
    _offset -= Offset(2 * _size.width, 0);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (tempList.isEmpty) {
      tempList = List.from(_listCard);
      tempList.shuffle();
    }
    tempList.removeAt(0);
    _listCard = List.from(tempList);

    resetPosition();
  }
}
