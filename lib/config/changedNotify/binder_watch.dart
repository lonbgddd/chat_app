import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/model.dart';
import 'package:flutter/cupertino.dart';

class BinderWatch extends ChangeNotifier {
  List<User> _listCard = [];
  Offset _offset = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;

  Offset get position => _offset;

  bool get isDragging => _isDragging;
  Size _size = Size.zero;

  List<User> get listCard => _listCard;

  void initData() {
    _listCard = [];
  }

  Future<List<User>> allUserBinder() async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;

      final users = await DatabaseMethods().getAllUser(uid);
      _listCard = users ?? [];
      // notifyListeners();

      return _listCard;
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
    final status = getStatus();

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

  Future addFollow(String followId) async {
    try {
      final uid =
          await HelpersFunctions().getUserIdUserSharedPreference() as String;
      await DatabaseMethods().addFollow(uid, followId);
      String check = await DatabaseMethods().checkFollow(uid, followId);
      if (check == "follow") {
        List<String> users = [uid, followId];
        String chatRoomId = getChatRoomId(uid, followId);
        Map<String, dynamic> chatRoom = {
          "users": users,
          "chatRoomId": chatRoomId,
        };
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

  StatusCard? getStatus() {
    final x = _offset.dx;

    const delta = 100;

    if (x >= delta) {
      return StatusCard.like;
    } else if (x <= -delta) {
      return StatusCard.dislike;
    }
  }

  void like() {
    _angle = 20;
    _offset += Offset(2 * _size.width, 0);
    _nextCard();

    notifyListeners();
  }

  Future _nextCard() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _listCard.removeAt(0);
    resetPosition();
  }

  void disLike() {
    _angle = -20;
    _offset -= Offset(2 * _size.width, 0);
    _nextCard();

    notifyListeners();
  }
}
