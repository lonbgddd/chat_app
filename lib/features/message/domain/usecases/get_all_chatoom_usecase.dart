import '../entities/chat_room_entity.dart';
import '../repositories/chat_room_repository.dart';

class GetAllChatRoomsUseCase {
  final ChatRoomRepository _chatRoomRepository;
  GetAllChatRoomsUseCase(this._chatRoomRepository);

  Stream<List<ChatRoomEntity>> call(String uid) {
    return _chatRoomRepository.getAllChatRooms(uid);
  }
}