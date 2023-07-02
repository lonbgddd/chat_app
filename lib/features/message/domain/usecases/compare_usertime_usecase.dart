import 'package:chat_app/features/message/domain/entities/user_time_entity.dart';

import '../repositories/chat_room_repository.dart';

class CompareUserTimeUseCase {
  final ChatRoomRepository _chatRoomRepository;

  CompareUserTimeUseCase(this._chatRoomRepository);

  Future<void> call(String uid, String chatRoomId) {
    return _chatRoomRepository.compareUserTime(chatRoomId, uid);
  }
}