import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetMyInfoUseCase {
  final UserRepository _userRepository;
  GetMyInfoUseCase(this._userRepository);

  Future<UserEntity> call(String uid) {
    return _userRepository.getUserInformation(uid);
  }
}