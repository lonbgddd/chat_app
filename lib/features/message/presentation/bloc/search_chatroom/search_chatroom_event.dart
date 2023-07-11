import 'package:equatable/equatable.dart';

abstract class SearchChatRoomEvent extends Equatable {
  const SearchChatRoomEvent();

  @override
  List<Object> get props => [];
}

class SearchChatRooms extends SearchChatRoomEvent{
  const SearchChatRooms();
}