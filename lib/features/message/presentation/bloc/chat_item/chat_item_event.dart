part of 'chat_item_bloc.dart';

abstract class ChatItemEvent extends Equatable {
  const ChatItemEvent();

  @override
  List<Object> get props => [];
}

class GetChatItem extends ChatItemEvent {
  final String uid;
  final String chatRoomId;
  const GetChatItem(this.uid, this.chatRoomId);
}

class ShowDetail extends ChatItemEvent {
  final UserEntity user;
  const ShowDetail(this.user);
}
