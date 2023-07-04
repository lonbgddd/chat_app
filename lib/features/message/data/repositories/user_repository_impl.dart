import 'package:chat_app/features/message/domain/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasources/user_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);
  @override
  Future<MyUserModal> getUserInformation(String uid) {
    return _userService.getUserInformation(uid);
  }

  @override
  Stream<UserEntity> getInfoUser(String uid) {
    return _userService.getInfoUser(uid);
  }

}