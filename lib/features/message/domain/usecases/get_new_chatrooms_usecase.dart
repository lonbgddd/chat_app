import '../entities/chat_room_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetNewChatRoomsUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetNewChatRoomsUseCase(this._chatRoomRepository);

  Stream<List<ChatRoomEntity>> call(String uid) {
    return _chatRoomRepository.getNewChatRooms(uid);
  }
}