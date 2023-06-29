part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {
  const MessageInitial();
}

class ChatRoomsLoading extends MessageState {
  const ChatRoomsLoading();
}

class ChatRoomsLoaded extends MessageState {
  final String currentUserId;
  final Stream<List<ChatRoomEntity>> chatRoomsStream;
  const ChatRoomsLoaded(this.chatRoomsStream, this.currentUserId);
  // final List<ChatRoomEntity> chatRooms;

  // const ChatRoomsLoaded(this.chatRooms);
}
