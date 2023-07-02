import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/chat_room.dart';
import '../../model/chat_user.dart';
import '../data_mothes.dart';

class DetailMessageProvider extends ChangeNotifier {
  var messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int? maxLines;
  File? image;
  bool showEmoji = false;
  bool checkTime = false;
  String? userTime;
  String? detailTime;
  getChats(String chatRoomId) async {
    return await DatabaseMethods().getChats(chatRoomId);
  }

  addMessage(String chatRoomId, String uid, String token) async {
    if (messageController.text.isNotEmpty && image == null) {
      DatabaseMethods().addMessage(
          chatRoomId ?? "",
          ChatMessage(
              uid: uid ?? "",
              messageText: messageController.text,
              imageURL: '',
              time: DateTime.now()),
          token ?? "");
      messageController.text = "";
      maxLines = null;
      notifyListeners();
    } else if (messageController.text.isEmpty && image != null) {
      DateTime time = DateTime.now();
      String url =
          await DatabaseMethods().pushImage(image, '${uid}${time.toString()}');
      DatabaseMethods().addMessage(
          chatRoomId ?? "",
          ChatMessage(
              uid: uid ?? "",
              messageText: '',
              imageURL: url,
              time: DateTime.now()),
          token ?? "");
      image = null;
      notifyListeners();
    }
  }
  compareTimeSelf(String uid, String chatRoomId) async {
    final chat = await FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .limit(1)
        .get();
    ChatMessage lastChat = ChatMessage.fromJson(chat.docs.first.data());
    final myUserTime = await DatabaseMethods().getUserTime(uid, chatRoomId);
    DateTime dateTimeA = lastChat.time;
    DateTime dateTimeB = DateTime.parse(myUserTime);
    if(dateTimeA.compareTo(dateTimeB) > 0){
      await DatabaseMethods().updateUserTime(uid, chatRoomId,lastChat.time.toString());
    }
    notifyListeners();
  }
  getUserTime(String uid, String chatRoomId) async {
    try {
      userTime = await DatabaseMethods().getUserTime(uid, chatRoomId);
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Xử lý ảnh đã chọn ở đây
        // Ví dụ: hiển thị ảnh trong một ImageView
        image = File(pickedFile.path);
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print('$e');
    }
  }

  setShowEmoji(bool value) {
    showEmoji = value;
    checkTime = !checkTime;
    notifyListeners();
  }

  setMaxLines(int? value) {
    maxLines = value;
    notifyListeners();
  }
  setFocusNode(BuildContext context){
    FocusScope.of(context).unfocus();
    notifyListeners();
  }
  setImageNull(){
    image = null;
    notifyListeners();
  }
  setDetailTime(String value){
    detailTime = value;
    notifyListeners();
  }

}
