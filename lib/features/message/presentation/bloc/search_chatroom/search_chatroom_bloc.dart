import 'dart:async';

import 'package:chat_app/features/message/domain/entities/user_entity.dart';
import 'package:chat_app/features/message/domain/usecases/get_all_chatoom_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_list_user_usecase.dart';
import 'package:chat_app/features/message/presentation/bloc/search_chatroom/search_chatroom_event.dart';
import 'package:chat_app/features/message/presentation/bloc/search_chatroom/search_chatroom_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/helpers/helpers_database.dart';

class SearchChatRoomBloc extends Bloc<SearchChatRoomEvent, SearchChatRoomState> {
  final GetAllChatRoomsUseCase _getAllChatRoomsUseCase;
  final GetListUserChatUseCase _getListUserChatUseCase;
  SearchChatRoomBloc(this._getAllChatRoomsUseCase,this._getListUserChatUseCase) : super(const SearchChatRoomInitial()) {
    on<SearchChatRooms>(getAllChatRooms);
  }

  void getAllChatRooms(SearchChatRooms event, Emitter<SearchChatRoomState> emit) async {
    String? uid = await HelpersFunctions().getUserIdUserSharedPreference();
    List<UserEntity> users = await _getListUserChatUseCase(uid!);
    emit(ChatRoomsLoaded(_getAllChatRoomsUseCase(uid!),users));
  }
}