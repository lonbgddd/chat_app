import 'package:chat_app/features/message/domain/entities/chat_message_entity.dart';
import 'package:chat_app/features/message/domain/entities/chat_room_entity.dart';

import '../../domain/repositories/chat_room_repository.dart';
import '../datasources/chat_room_service.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final ChatRoomService _chatRoomApi;

  ChatRoomRepositoryImpl(this._chatRoomApi);

  @override
  Stream<List<ChatRoomModel>> getChatRooms(String uid) {
    return _chatRoomApi.getChatRoomFromFireStore(uid);
  }

  @override
  Stream<List<ChatMessageModel>> getMessages(String chatRoomId) {
    return _chatRoomApi.getChatMessagesStream(chatRoomId);
  }

  @override
  Stream<ChatMessageEntity> getLastMessage(String chatRoomId) {
    return _chatRoomApi.getLastMessage(chatRoomId);
  }

  @override
  Future<void> addMessage(String uid, String chatRoomId, String messageContent,
      String imageUrl, String avatar, String name) {
    return _chatRoomApi.addMessage(
        uid, chatRoomId, messageContent, imageUrl, avatar, name);
  }

  @override
  Future<void> compareUserTime(String chatRoomId, String uid) {
    return _chatRoomApi.compareUserTimeSelf(uid, chatRoomId);
  }

  @override
  Stream<ChatRoomModel> getChatRoom(String uid, String chatRoomId) {
    return _chatRoomApi.getChatRoom(uid, chatRoomId);
  }

  @override
  Stream<List<ChatRoomEntity>> getNewChatRooms(String uid) {
    return _chatRoomApi.getNewChatRoomFromFireStore(uid);
  }

  @override
  Future<ChatRoomEntity> getNewChatRoom(String chatRoomId) {
    return _chatRoomApi.getNewChatRoom(chatRoomId);
  }
}
