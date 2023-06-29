import 'package:chat_app/features/message/domain/entities/chat_message_entity.dart';

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
  Future<void> addMessage(String uid, String chatRoomId, String messageContent, String imageUrl, String token) {
    return _chatRoomApi.addMessage(uid, chatRoomId, messageContent, imageUrl, token);
  }
}