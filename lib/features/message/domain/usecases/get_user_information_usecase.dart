import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUserInformationUserCase {
  final UserRepository _userRepository;
  GetUserInformationUserCase(this._userRepository);

  Future<UserEntity> call(String uid) {
    return _userRepository.getUserInformation(uid);
  }
}