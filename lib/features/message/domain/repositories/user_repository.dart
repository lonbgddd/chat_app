import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUserInformation(String uid);
  Future<List<UserEntity>> getListUserChat(String uid);
  Stream<UserEntity> getInfoUser(String uid);
}