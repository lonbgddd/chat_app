

import 'package:chat_app/config/data_mothes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class SearchMessageProvider extends ChangeNotifier{
  String name ='';
  void search(String name){
    this.name = name;
    notifyListeners();
  }
  Future<List<User>> getListUserChat(String uid) async {
    try {
      List<User> users = await DatabaseMethods().getListUserChat(uid);
      notifyListeners();
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }
}