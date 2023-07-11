import 'package:chat_app/features/message/domain/repositories/user_repository.dart';
import '../entities/user_entity.dart';

class GetListUserChatUseCase {
  final UserRepository _userRepository;
  GetListUserChatUseCase(this._userRepository);

  Future<List<UserEntity>> call(String uid) {
    return _userRepository.getListUserChat(uid);
  }
}