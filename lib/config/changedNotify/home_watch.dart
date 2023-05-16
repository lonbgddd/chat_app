import 'package:chat_app/model/model.dart';
import 'package:flutter/cupertino.dart';

class HomeNotify extends ChangeNotifier {
  final List<User>? listUser = [];

  // Stream<List<User>?>? getUserChats(String uid) async {
  //   final users = DatabaseMethods().getUserChats(uid);
  //
  //   return users;
  // }
}
