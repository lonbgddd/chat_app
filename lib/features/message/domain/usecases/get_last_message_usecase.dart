import '../entities/chat_message_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetLastMessageUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetLastMessageUseCase(this._chatRoomRepository);

  Stream<ChatMessageEntity> call(String chatRoomId) {
    return _chatRoomRepository.getLastMessage(chatRoomId);
  }
}