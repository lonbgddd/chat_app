part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState  {
  const MessageInitial();
}

class ChatRoomsLoading extends MessageState {
  const ChatRoomsLoading();
}

class ChatRoomsLoaded extends MessageState {
  final String currentUserId;
  final UserEntity user;
  final Stream<List<ChatRoomEntity>> chatRoomsStream;
  final Stream<List<ChatRoomEntity>> newChatRoomsStream;
  const ChatRoomsLoaded(this.chatRoomsStream, this.currentUserId,this.user,this.newChatRoomsStream);
}

