import 'dart:async';

import 'package:chat_app/features/message/domain/entities/chat_room_entity.dart';
import 'package:chat_app/features/message/domain/usecases/get_chatroom_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_last_message_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/helpers/helpers_database.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_new_chatroom.dart';
import '../../../domain/usecases/get_user_information_usecase.dart';

part 'chat_item_event.dart';
part 'chat_item_state.dart';

class ChatItemBloc extends Bloc<ChatItemEvent, ChatItemState> {
  final GetLastMessageUseCase _getLastMessageUseCase;
  final GetUserInformationUserCase _getUserInformationUserCase;
  final GetNewChatRoomUseCase _getNewChatRoomUseCase;
  ChatItemBloc(this._getLastMessageUseCase, this._getUserInformationUserCase,this._getNewChatRoomUseCase)
      : super(const ChatItemInitial()) {
    on<GetChatItem>(getChatItem);
    on<ShowDetail>(showDetail);
  }

  FutureOr<void> getChatItem(GetChatItem event, Emitter<ChatItemState> emit) async {
    UserEntity user = await _getUserInformationUserCase(event.uid);
    Stream<ChatMessageEntity> lastMessageStream = _getLastMessageUseCase(event.chatRoomId);
    ChatRoomEntity chatRoom = await _getNewChatRoomUseCase(event.chatRoomId);
    List<String>? newUsers = chatRoom.newChatRoom;
    bool isNewChatRoom = true;
    String? myUid = await HelpersFunctions().getUserIdUserSharedPreference();
    for(var index in newUsers!){
      if(index == myUid){
        isNewChatRoom = false;
      }
    }
    emit(ChatItemLoaded(user, lastMessageStream, isNewChatRoom));
  }

  FutureOr<void> showDetail(ShowDetail event, Emitter<ChatItemState> emit) {
    emit(ChatItemClicked(event.user));
  }
}
