import 'dart:async';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_room_entity.dart';
import '../../../domain/usecases/get_chatrooms_usecase.dart';

part 'message_event.dart';
part 'message_state.dart';
class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetChatRoomsUseCase _getChatRoomsUseCase;

  MessageBloc(this._getChatRoomsUseCase) : super(const MessageInitial()) {
    emit(const ChatRoomsLoading());
    on<GetChatRooms>(getChatRooms);
  }

  Future<FutureOr<void>> getChatRooms(GetChatRooms event, Emitter<MessageState> emit) async {
    String? uid = await HelpersFunctions().getUserIdUserSharedPreference();
      emit(ChatRoomsLoaded(_getChatRoomsUseCase(uid!),uid));
    // await for (List<ChatRoomEntity> chatRooms in _getChatRoomsUseCase(uid!)) {
    //   emit(ChatRoomsLoaded(chatRooms));
    // }
  }
}