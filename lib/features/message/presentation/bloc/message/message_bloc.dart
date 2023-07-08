import 'dart:async';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:chat_app/features/message/domain/entities/user_entity.dart';
import 'package:chat_app/features/message/domain/usecases/get_my_info_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_new_chatrooms_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/chat_room_entity.dart';
import '../../../domain/usecases/get_chatrooms_usecase.dart';

part 'message_event.dart';
part 'message_state.dart';
class MessageBloc extends Bloc<MessageEvent, MessageState> {

  final GetChatRoomsUseCase _getChatRoomsUseCase;
  final GetMyInfoUseCase _getMyInfoUseCase;
  final GetNewChatRoomsUseCase _getNewChatRoomsUseCase;

  MessageBloc(this._getChatRoomsUseCase,this._getMyInfoUseCase,this._getNewChatRoomsUseCase) : super(const MessageInitial()) {
    emit(const ChatRoomsLoading());
    on<GetChatRooms>(getChatRooms);
  }

  FutureOr<void> getChatRooms(GetChatRooms event, Emitter<MessageState> emit) async {
    String? uid = await HelpersFunctions().getUserIdUserSharedPreference();
    UserEntity user = await _getMyInfoUseCase(uid!);
    emit(ChatRoomsLoaded(_getChatRoomsUseCase(uid!),uid!,user,_getNewChatRoomsUseCase(uid!)));
  }


}