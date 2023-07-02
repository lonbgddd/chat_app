import 'package:equatable/equatable.dart';

import 'chat_message_entity.dart';
import 'user_time_entity.dart';

class ChatRoomEntity extends Equatable   {
  String? chatRoomId;
  List<String>? users;
  List<UserTimeEntity>? userTimes;


  ChatRoomEntity({this.chatRoomId, this.users,
    this.userTimes,

  });

  @override
  List<Object?> get props => [chatRoomId, users,
    userTimes,

  ];
}