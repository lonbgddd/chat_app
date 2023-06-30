import '../entities/chat_message_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetMessagesUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetMessagesUseCase(this._chatRoomRepository);

  Stream<List<ChatMessageEntity>> call(String chatRoomId) {
    return _chatRoomRepository.getMessages(chatRoomId);
  }
}