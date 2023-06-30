import '../../domain/repositories/user_repository.dart';
import '../datasources/user_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);
  @override
  Future<UserModal> getUserInformation(String uid) {
    return _userService.getUserInformation(uid);
  }

}