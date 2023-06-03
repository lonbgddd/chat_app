import 'dart:convert';

ChatMessage chatMessageFromJson(String str) =>
    ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
  String uid;
  String messageText;
  String imageURL;
  DateTime time;
  ChatMessage(
      {required this.uid,
      required this.messageText,
      required this.imageURL,
      required this.time});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        time: DateTime.parse(json["time"]),
        messageText: json["messageText"],
        imageURL: json["imageURL"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "messageText": messageText,
        "imageURL": imageURL,
        "time": time.toIso8601String(),
      };
}
