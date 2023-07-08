import '../../domain/entities/chat_room_entity.dart';
import 'chat_message_model.dart';
import 'user_time_model.dart';

class ChatRoomModel extends ChatRoomEntity {
  ChatRoomModel(
      {String? chatRoomId,
      String? time,
      List<String>? newChatRoom,
      List<String>? users,
      List<UserTimeModel>? userTimes})
      : super(
            chatRoomId: chatRoomId,
            time: time,
            newChatRoom: newChatRoom,
            users: users,
            userTimes: userTimes
  );

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    List<dynamic>? userTimes = json["userTimes"];
    List<UserTimeModel> parsedUserTimes = userTimes != null
        ? userTimes.map((item) => UserTimeModel.fromJson(item)).toList()
        : [];

    return ChatRoomModel(
      chatRoomId: json["chatRoomId"],
      time: json["time"],
      newChatRoom: json["newChatRoom"]!= null? List<String>.from(json["newChatRoom"]) : [],
      users: List<String>.from(json["users"]),
      userTimes: parsedUserTimes,
    );
  }

  Map<String, dynamic> toJson() => {
        "chatRoomId": chatRoomId,
        "users": users,
        "userTimes": userTimes,
        "time": time,
        "newChatRoom": newChatRoom
      };
}
