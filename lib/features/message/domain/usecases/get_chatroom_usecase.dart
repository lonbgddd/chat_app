import 'package:chat_app/features/message/data/models/chat_room_model.dart';
import 'package:chat_app/features/message/domain/entities/chat_room_entity.dart';
import 'package:chat_app/features/message/domain/entities/user_time_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetChatRoomUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetChatRoomUseCase(this._chatRoomRepository);

  Stream<ChatRoomEntity> call(String uid, String chatRoomId) {
    return _chatRoomRepository.getChatRoom(uid,chatRoomId);
  }
}