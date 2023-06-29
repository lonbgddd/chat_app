part of 'detail_message_bloc.dart';

abstract class DetailMessageEvent extends Equatable {
  const DetailMessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessageList extends DetailMessageEvent {
  final String chatRoomId;

  const GetMessageList(this.chatRoomId);
}

class AddMessage extends DetailMessageEvent {
  final String uid;
  final String chatRoomId;
  final String content;
  final String imageUrl;
  final String token;

  const AddMessage(this.uid,this.chatRoomId, this.content, this.imageUrl, this.token);
}

class ShowEmojiPicker extends DetailMessageEvent {
  const ShowEmojiPicker();
}
