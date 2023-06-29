import 'package:equatable/equatable.dart';

import 'chat_message_entity.dart';
import 'user_time_entity.dart';

class ChatRoomEntity extends Equatable   {
  String? chatRoomId;
  List<String>? users;
  List<UserTimeEntity>? userTime;


  ChatRoomEntity({this.chatRoomId, this.users,
    this.userTime,

  });

  @override
  List<Object?> get props => [chatRoomId, users,
    userTime,

  ];
}