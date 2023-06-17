class ChatRoom {
  String chatRoomId;
  List<String> users;

  ChatRoom({required this.chatRoomId, required this.users});

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        chatRoomId: json["chatRoomId"],
        users: (json["users"] as List<dynamic>).cast<String>(),
      );

  Map<String, dynamic> toJson() => {
        "chatRoomId": chatRoomId,
        "users": users,
      };
}
