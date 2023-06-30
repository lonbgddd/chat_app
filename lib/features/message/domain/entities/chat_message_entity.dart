import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String? uid;
  final String? messageText;
  final String? imageURL;
  final DateTime? time;

  const ChatMessageEntity({this.uid, this.messageText, this.imageURL, this.time});

  @override
  List<Object?> get props => [uid, messageText, imageURL, time];
}
