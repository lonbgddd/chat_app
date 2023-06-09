import 'dart:io';

import '../entities/chat_message_entity.dart';
import '../entities/chat_room_entity.dart';
import '../entities/user_time_entity.dart';

abstract class ChatRoomRepository {
  Stream<List<ChatRoomEntity>> getChatRooms(String uid);

  Stream<List<ChatMessageEntity>> getMessages(String chatRoomId);

  Stream<ChatMessageEntity> getLastMessage(String chatRoomId);

  Stream<ChatRoomEntity> getChatRoom(String uid, String chatRoomId);

  Stream<List<ChatRoomEntity>> getNewChatRooms(String uid);

  Stream<List<ChatRoomEntity>> getAllChatRooms(String uid);

  Future<void> addMessage(String uid, String chatRoomId, String messageContent,
      File? image, String avatar, String name);

  Future<void> compareUserTime(String chatRoomId, String uid);

  Future<ChatRoomEntity> getNewChatRoom(String chatRoomId);

}
