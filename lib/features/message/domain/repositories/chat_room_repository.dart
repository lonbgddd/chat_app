import '../entities/chat_message_entity.dart';
import '../entities/chat_room_entity.dart';
import '../entities/user_time_entity.dart';

abstract class ChatRoomRepository {
  Stream<List<ChatRoomEntity>> getChatRooms(String uid);
  Stream<List<ChatMessageEntity>> getMessages(String chatRoomId);
  Stream<ChatMessageEntity> getLastMessage(String chatRoomId);
  Stream<ChatRoomEntity> getChatRoom(String uid,String chatRoomId);
  Stream<List<ChatRoomEntity>> getNewChatRooms(String uid);
  Future<void> addMessage(String uid, String chatRoomId, String messageContent, String imageUrl, String token);
  Future<void> compareUserTime(String chatRoomId,String uid);
  Future<ChatRoomEntity> getNewChatRoom(String chatRoomId);
}