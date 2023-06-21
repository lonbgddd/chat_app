import 'dart:math';
import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/firebase/firebase_api.dart';
import 'package:chat_app/config/helpers/enum_cal.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import '../../model/user_model.dart';

class BinderWatch extends ChangeNotifier {
  List<UserModal> _listCard = [];
  Offset _offset = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;

  Offset get position => _offset;

  bool get isDragging => _isDragging;
  Size _size = Size.zero;

  List<UserModal> get listCard => _listCard;

  void initData() {
    _listCard = [];
  }


  Future<List<UserModal>> allUserBinder() async {
    try {
      final uid =
      await HelpersFunctions().getUserIdUserSharedPreference() as String;
      final users = await DatabaseMethods().getAllUser(uid);
      print('List: $users');
      _listCard = users ?? [];

      return _listCard;
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<List<UserModal>> allUserBinder() async {
  //     return _listCard;
  // }
  //
  // // Inside BinderWatch class
  // Future<void> updateList() async {
  //   try {
  //     if (listCard.length > 2) return;
  //     final uid = await HelpersFunctions().getUserIdUserSharedPreference() as String;
  //     final users = await DatabaseMethods().getAllUser(uid);
  //     final List<UserModal> updatedUsers = [..._listCard, ...users];
  //     _listCard = updatedUsers;
  //     print(listCard.length);
  //     notifyListeners();
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

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
        Map<String, dynamic> chatRoom = {
          "users": users,
          "chatRoomId": chatRoomId,
        };
        await FirebaseApi()
            .sendPushMessage('Bạn có một tương hợp mới', 'Binder', token);
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
    _listCard.removeAt(0);
    resetPosition();
  }
}
