import '../entities/chat_room_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetNewChatRoomUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetNewChatRoomUseCase(this._chatRoomRepository);

  Future<ChatRoomEntity> call(String chatRoomId) {
    return _chatRoomRepository.getNewChatRoom(chatRoomId);
  }
}