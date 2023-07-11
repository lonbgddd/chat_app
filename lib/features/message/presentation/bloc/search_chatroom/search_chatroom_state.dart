import 'package:chat_app/features/message/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat_room_entity.dart';

abstract class SearchChatRoomState extends Equatable {
  const SearchChatRoomState();
  @override
  List<Object> get props => [];
}

class SearchChatRoomInitial extends SearchChatRoomState  {
  const SearchChatRoomInitial();
}

class ChatRoomsLoaded extends SearchChatRoomState {
  final Stream<List<ChatRoomEntity>> chatRooms;
  final List<UserEntity> listUsers;
  const ChatRoomsLoaded(this.chatRooms,this.listUsers);
}

