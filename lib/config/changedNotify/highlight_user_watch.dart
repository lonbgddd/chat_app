import 'dart:async';

import 'package:chat_app/config/data_mothes.dart';
import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/model/chat_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/user_model.dart';
import '../helpers/app_assets.dart';

class HighlightUserNotify extends ChangeNotifier {

  bool  _highlightedUser = false;
 late Timer _countdownTimer;
 String idHighlightedDelete = '';

  bool get highlightedUser => _highlightedUser;

  set highlightedUser(bool value) {
    _highlightedUser = value;
  }



  @override
  void dispose() {

    super.dispose();
  }


  Timer get countdownTimer => _countdownTimer;

  set countdownTimer(Timer value) {
    _countdownTimer = value;
  }

  void startHighlight(UserModel currentUser, UserModel targetUser, int time) {
    activateHighlight(currentUser, targetUser);
    idHighlightedDelete = currentUser.uid;
    print("Id xóa: $idHighlightedDelete");
    _highlightedUser = currentUser.isHighlighted;
    _countdownTimer = Timer(Duration(minutes: time), () async {
      await resetHighlight(currentUser);
      cancelHighlight();
    });
  }

  void cancelHighlight() {
    _highlightedUser = false;
    _countdownTimer.cancel();
    notifyListeners();
  }

  Future<void> activateHighlight(UserModel currentUser, UserModel targetUser) async {
    final currentTime = DateTime.now();

    currentUser.isHighlighted = true;
    currentUser.highlightTime = currentTime.toString();

    await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
      'isHighlighted': true,
      'highlightTime': currentTime.toString(),
    });
    await FirebaseFirestore.instance.collection('users').doc(targetUser.uid).collection('highlights').doc(currentUser.uid).set({
      'highlightTime': currentTime.toString(),
    });
    notifyListeners();
  }

  // Future<void> updateTemp(List<String> uids) async {
  //   for(int i = 0 ; i < uids.length; i++){
  //     await FirebaseFirestore.instance.collection('users').doc(uids[i]).update({
  //       "followersList": [],
  //     });
  //   }
  //
  //
  // }



  List<UserModel> sortUsers(List<UserModel> users) {
    users.sort((a, b) {
      if (a.isHighlighted && !b.isHighlighted) {
        return -1;
      } else if (!a.isHighlighted && b.isHighlighted) {
        return 1;
      } else if (a.isHighlighted && b.isHighlighted) {
        return b.highlightTime.compareTo(a.highlightTime);
      } else {
        return 0;
      }
    });

    return users;
  }
  Future<void> resetHighlight(UserModel currentUser) async {
    if (currentUser.isHighlighted && currentUser.highlightTime != null) {

        currentUser.isHighlighted = false;
        currentUser.highlightTime = '';

        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
          'isHighlighted': false,
          'highlightTime': '',
        });

        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).collection('highlights').doc(idHighlightedDelete).delete();
        notifyListeners();
    }

  }






}
