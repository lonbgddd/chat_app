

import '../../domain/entities/chat_room_entity.dart';
import 'chat_message_model.dart';
import 'user_time_model.dart';

class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel(
      {String? chatRoomId,
      List<String>? users,
      List<UserTimeModel>? userTime})
      : super(
            chatRoomId: chatRoomId,
            users: users,
            userTime: userTime);

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {

    return ChatRoomModel(
        chatRoomId: json["chatRoomId"],
        users: (json["users"] as List<dynamic>).cast<String>(),
        userTime: json["userTime"] != null
            ? (json["userTime"] as List<UserTimeModel>).cast<UserTimeModel>()
            : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "chatRoomId": chatRoomId,
        "users": users,
        "userTime": userTime,
      };
}
