import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
      String? uid, String? messageText, String? imageURL, DateTime? time})
      : super(
            uid: uid, messageText: messageText, imageURL: imageURL, time: time);

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    uid: json["uid"],
    messageText: json["messageText"],
    imageURL: json["imageURL"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "messageText": messageText,
    "imageURL": imageURL,
    "time": time!.toIso8601String(),
  };
}
