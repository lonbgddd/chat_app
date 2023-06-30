import '../repositories/chat_room_repository.dart';

class AddMessageUseCase {
  final ChatRoomRepository _chatRoomRepository;

  AddMessageUseCase(this._chatRoomRepository);

  Future<void> call(String uid,
      String chatRoomId, String messageContent, String imageUrl, String token) {
    return _chatRoomRepository.addMessage(uid,
        chatRoomId, messageContent, imageUrl, token);
  }
}
