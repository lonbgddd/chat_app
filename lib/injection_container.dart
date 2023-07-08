
import 'package:chat_app/features/message/data/datasources/chat_room_service.dart';
import 'package:chat_app/features/message/data/datasources/user_service.dart';
import 'package:chat_app/features/message/data/repositories/chat_room_repository_impl.dart';
import 'package:chat_app/features/message/data/repositories/user_repository_impl.dart';
import 'package:chat_app/features/message/domain/repositories/chat_room_repository.dart';
import 'package:chat_app/features/message/domain/repositories/user_repository.dart';
import 'package:chat_app/features/message/domain/usecases/add_message_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/compare_usertime_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_new_chatroom.dart';
import 'package:chat_app/features/message/domain/usecases/get_chatrooms_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_info_user_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_last_message_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_messages_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_my_info_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_new_chatrooms_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_user_information_usecase.dart';
import 'package:chat_app/features/message/domain/usecases/get_chatroom_usecase.dart';
import 'package:chat_app/features/message/presentation/bloc/chat_item/chat_item_bloc.dart';
import 'package:chat_app/features/message/presentation/bloc/detail_message/detail_message_bloc.dart';
import 'package:chat_app/features/message/presentation/bloc/message/message_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dependencies


  sl.registerSingleton<ChatRoomService>(const ChatRoomService());
  sl.registerSingleton<ChatRoomRepository>(ChatRoomRepositoryImpl(sl()));

  sl.registerSingleton<UserService>(const UserService());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));
  // User case

  sl.registerSingleton<GetChatRoomsUseCase>(GetChatRoomsUseCase(sl()));
  sl.registerSingleton<GetLastMessageUseCase>(GetLastMessageUseCase(sl()));
  sl.registerSingleton<GetMessagesUseCase>(GetMessagesUseCase(sl()));
  sl.registerSingleton<GetUserInformationUserCase>(GetUserInformationUserCase(sl()));
  sl.registerSingleton<AddMessageUseCase>(AddMessageUseCase(sl()));
  sl.registerSingleton<CompareUserTimeUseCase>(CompareUserTimeUseCase(sl()));
  sl.registerSingleton<GetChatRoomUseCase>(GetChatRoomUseCase(sl()));
  sl.registerSingleton<GetInfoUserUseCase>(GetInfoUserUseCase(sl()));
  sl.registerSingleton<GetMyInfoUseCase>(GetMyInfoUseCase(sl()));
  sl.registerSingleton<GetNewChatRoomsUseCase>(GetNewChatRoomsUseCase(sl()));
  sl.registerSingleton<GetNewChatRoomUseCase>(GetNewChatRoomUseCase(sl()));
  // Bloc

  sl.registerFactory<MessageBloc>(() => MessageBloc(sl(),sl(),sl()));
  sl.registerFactory<ChatItemBloc>(() => ChatItemBloc(sl(),sl(),sl()));
  sl.registerFactory<DetailMessageBloc>(() => DetailMessageBloc(sl(), sl(),sl(),sl(),sl()));
}
