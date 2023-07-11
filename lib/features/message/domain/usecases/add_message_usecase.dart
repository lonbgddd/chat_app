import 'dart:io';

import '../repositories/chat_room_repository.dart';

class AddMessageUseCase {
  final ChatRoomRepository _chatRoomRepository;

  AddMessageUseCase(this._chatRoomRepository);

  Future<void> call(String uid, String chatRoomId, String messageContent,
      File? image, String avatar, String name) {
    return _chatRoomRepository.addMessage(
        uid, chatRoomId, messageContent, image, avatar, name);
  }
}
