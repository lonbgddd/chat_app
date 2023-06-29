import 'dart:async';

import 'package:chat_app/features/message/domain/usecases/get_messages_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/usecases/add_message_usecase.dart';

part 'detail_message_event.dart';

part 'detail_message_state.dart';

class DetailMessageBloc extends Bloc<DetailMessageEvent, DetailMessageState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final AddMessageUseCase _addMessageUseCase;

  DetailMessageBloc(this._getMessagesUseCase, this._addMessageUseCase)
      : super(const DetailMessageInitial()) {
    on<GetMessageList>(getMessageList);
    on<AddMessage>(addMessage);
    on<ShowEmojiPicker>(showEmojiPicker);
  }

  FutureOr<void> getMessageList(
      GetMessageList event, Emitter<DetailMessageState> emit) async {
    emit(const MessageListLoading());
    emit(MessageListLoaded(_getMessagesUseCase(event.chatRoomId)));
  }

  FutureOr<void> addMessage(
      AddMessage event, Emitter<DetailMessageState> emit) {
    _addMessageUseCase(event.uid, event.chatRoomId, event.content,
        event.imageUrl, event.token);
  }

  FutureOr<void> showEmojiPicker(
      ShowEmojiPicker event, Emitter<DetailMessageState> emit) {
    emit(const EmojiPickerShow());
  }
}
