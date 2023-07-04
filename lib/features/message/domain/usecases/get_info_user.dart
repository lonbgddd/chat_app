import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetInfoUserUseCase {
  final UserRepository _userRepository;
  GetInfoUserUseCase(this._userRepository);

  Stream<UserEntity> call(String uid) {
    return _userRepository.getInfoUser(uid);
  }
}