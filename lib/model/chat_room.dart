import 'package:chat_app/model/user_time.dart';

class ChatRoom {
  String chatRoomId;
  List<String> users;
  List<UserTime> userTimes;
  ChatRoom({required this.chatRoomId, required this.users,required this.userTimes,});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        chatRoomId: json["chatRoomId"],
        users: (json["users"] as List<dynamic>).cast<String>(),
        userTimes: (json["userTimes"] as List<dynamic>).cast<UserTime>(),
      );

  Map<String, dynamic> toJson() => {
        "chatRoomId": chatRoomId,
        "users": users,
      };
}
