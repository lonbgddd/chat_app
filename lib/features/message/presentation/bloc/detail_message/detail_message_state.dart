part of 'detail_message_bloc.dart';

abstract class DetailMessageState extends Equatable {
  const DetailMessageState();

  @override
  List<Object> get props => [];
}

class DetailMessageActionState extends DetailMessageState {
  const DetailMessageActionState();
}

class DetailMessageInitial extends DetailMessageState {
  const DetailMessageInitial();
}

class MessageListLoading extends DetailMessageState {
  const MessageListLoading();
}

class MessageListLoaded extends DetailMessageState {
  final Stream<List<ChatMessageEntity>> messagesList;
  final Stream<ChatRoomEntity> chatRoom;
  const MessageListLoaded(this.chatRoom,this.messagesList);
}

class EmojiPickerShow extends DetailMessageState {
  const EmojiPickerShow();
}
class WatchTimeState extends DetailMessageState{
  const WatchTimeState();
}
