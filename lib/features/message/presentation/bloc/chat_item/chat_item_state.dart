part of 'chat_item_bloc.dart';

abstract class ChatItemState extends Equatable {
  const ChatItemState();
  @override
  List<Object> get props => [];
}

class ChatItemActionState extends ChatItemState {
  const ChatItemActionState();
}

class ChatItemInitial extends ChatItemState {
  const ChatItemInitial();
}

class ChatItemLoaded extends ChatItemState {
  final UserEntity user;
  final bool isNewChatRoom;
  final Stream<ChatMessageEntity> lastMessageStream;
  const ChatItemLoaded(this.user, this.lastMessageStream,this.isNewChatRoom);
}

class ChatItemClicked extends ChatItemActionState {
  final UserEntity user;
  const ChatItemClicked(this.user);
}
