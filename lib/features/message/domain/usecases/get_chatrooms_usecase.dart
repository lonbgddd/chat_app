import '../entities/chat_room_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetChatRoomsUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetChatRoomsUseCase(this._chatRoomRepository);

  Stream<List<ChatRoomEntity>> call(String uid) {
    return _chatRoomRepository.getChatRooms(uid);
  }
}