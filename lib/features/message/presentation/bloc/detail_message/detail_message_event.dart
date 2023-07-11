part of 'detail_message_bloc.dart';

abstract class DetailMessageEvent extends Equatable {
  const DetailMessageEvent();

  @override
  List<Object> get props => [];
}

class GetMessageList extends DetailMessageEvent {
  final String watchTime;
  final bool showEmoji;
  final File? image;
  final String uid;
  final String chatRoomId;
  const GetMessageList(this.uid ,this.chatRoomId,this.showEmoji,this.image,this.watchTime);
}

class AddMessage extends DetailMessageEvent {
  final String uid;
  final String chatRoomId;
  final String content;
  final File? image;
  final String avatar;
  final String name;

  const AddMessage(this.uid, this.chatRoomId, this.content, this.image,
      this.avatar, this.name);
}

class CompareUserTime extends DetailMessageEvent {
  final String uid;
  final String chatRoomId;

  const CompareUserTime(this.uid, this.chatRoomId);
}

class ShowEmojiPicker extends DetailMessageEvent {
  const ShowEmojiPicker();
}

class WatchTimeEvent extends DetailMessageEvent {
  final String value;

  const WatchTimeEvent(this.value);
}
// class GetInfoUser extends DetailMessageEvent{
//   final String uid;
//   const GetInfoUser(this.uid);
// }
// class GetChatRoom extends DetailMessageEvent {
//   final String uid;
//   final String chatRoomId;
//   const GetChatRoom(this.uid,this.chatRoomId);
// }

