import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUserInformation(String uid);
  Stream<UserEntity> getInfoUser(String uid);
}