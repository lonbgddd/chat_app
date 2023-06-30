import 'dart:async';

import 'package:chat_app/features/message/domain/usecases/get_last_message_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_user_information_usecase.dart';

part 'chat_item_event.dart';
part 'chat_item_state.dart';

class ChatItemBloc extends Bloc<ChatItemEvent, ChatItemState> {
  final GetLastMessageUseCase _getLastMessageUseCase;
  final GetUserInformationUserCase _getUserInformationUserCase;

  ChatItemBloc(this._getLastMessageUseCase, this._getUserInformationUserCase)
      : super(const ChatItemInitial()) {
    on<GetChatItem>(getChatItem);
    on<ShowDetail>(showDetail);
  }

  FutureOr<void> getChatItem(
      GetChatItem event, Emitter<ChatItemState> emit) async {
    UserEntity user = await _getUserInformationUserCase(event.uid);
    Stream<ChatMessageEntity> lastMessageStream =
        _getLastMessageUseCase(event.chatRoomId);
    emit(ChatItemLoaded(user, lastMessageStream));
  }

  FutureOr<void> showDetail(ShowDetail event, Emitter<ChatItemState> emit) {
    emit(ChatItemClicked(event.user));
  }
}
