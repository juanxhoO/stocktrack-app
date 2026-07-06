import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> searchUsers({String? query});

  Future<User> getUser(String id);

  Future<User> createUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? photo,
    String? socialId,
    String? role,
    String? status,
    String? provider,
  });

  Future<User> updateUser({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? photo,
    String? provider,
    String? socialId,
    String? role,
    String? status,
  });

  Future<void> deleteUser(String id);
}
