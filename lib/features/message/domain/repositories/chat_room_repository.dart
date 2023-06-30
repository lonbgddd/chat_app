import '../entities/chat_message_entity.dart';
import '../entities/chat_room_entity.dart';

abstract class ChatRoomRepository {
  Stream<List<ChatRoomEntity>> getChatRooms(String uid);
  Stream<List<ChatMessageEntity>> getMessages(String chatRoomId);
  Stream<ChatMessageEntity> getLastMessage(String chatRoomId);

  Future<void> addMessage(String uid, String chatRoomId, String messageContent, String imageUrl, String token);
}