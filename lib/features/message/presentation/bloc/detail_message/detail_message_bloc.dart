import 'dart:async';

import 'package:chat_app/features/message/data/models/chat_room_model.dart';
import 'package:chat_app/features/message/data/models/user_time_model.dart';
import 'package:chat_app/features/message/domain/entities/chat_room_entity.dart';
import 'package:chat_app/features/message/domain/entities/user_time_entity.dart';
import 'package:chat_app/features/message/domain/usecases/compare_usertime_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_info_user_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_chatroom_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_user_information_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/add_message_usecase.dart';

part 'detail_message_event.dart';

part 'detail_message_state.dart';

class DetailMessageBloc extends Bloc<DetailMessageEvent, DetailMessageState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final AddMessageUseCase _addMessageUseCase;
  final CompareUserTimeUseCase _compareUserTimeUseCase;
  final GetChatRoomUseCase _getChatRoomUserCase;
  final GetInfoUserUseCase _getInfoUserUseCase;


  DetailMessageBloc(this._getMessagesUseCase, this._addMessageUseCase,this._compareUserTimeUseCase,this._getChatRoomUserCase,this._getInfoUserUseCase)
      : super(const DetailMessageInitial()) {
    on<GetMessageList>(getMessageList);
    on<AddMessage>(addMessage);
    on<ShowEmojiPicker>(showEmojiPicker);
    on<CompareUserTime>(compareUserTime);
    on<WatchTimeEvent>(watchTime);

  }

  FutureOr<void> getMessageList(GetMessageList event, Emitter<DetailMessageState> emit) async {
    emit(const MessageListLoading());
    Stream<ChatRoomEntity> chatRoom = _getChatRoomUserCase(event.uid,event.chatRoomId);
    emit(MessageListLoaded(_getChatRoomUserCase(event.uid,event.chatRoomId),_getMessagesUseCase(event.chatRoomId),_getInfoUserUseCase(event.uid),event.showEmoji));
  }


  FutureOr<void> addMessage(AddMessage event, Emitter<DetailMessageState> emit) {
    _addMessageUseCase(event.uid, event.chatRoomId, event.content,
        event.imageUrl, event.token);
  }
  FutureOr<void> compareUserTime(CompareUserTime event, Emitter<DetailMessageState> emit) {
    _compareUserTimeUseCase(event.uid, event.chatRoomId);
  }

  FutureOr<void> showEmojiPicker(
      ShowEmojiPicker event, Emitter<DetailMessageState> emit) {
    emit(const EmojiPickerShow());
  }

  FutureOr<void> watchTime(WatchTimeEvent event, Emitter<DetailMessageState> emit) {
    final currentState = state as WatchTimeState;
    if (currentState.value != event.value) {
      emit(WatchTimeState(event.value));
    }
  }
  // FutureOr<void> getInfoUser(GetInfoUser event, Emitter<DetailMessageState> emit) async{
  //     emit(GetInfoUserLoaded(_getInfoUserUseCase(event.uid)));
  // }
}
