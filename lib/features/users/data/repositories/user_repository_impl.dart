import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remote;

  UserRepositoryImpl(this.remote);

  @override
  Future<List<User>> searchUsers({String? query}) {
    return remote.searchUsers(query: query);
  }

  @override
  Future<User> createUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? socialId,
    String? role,
    String? status,
    String? provider,
    String? photo,
  }) {
    return remote.createUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      socialId: socialId,
      role: role,
      photo: photo,
      status: status,
      provider: provider,
    );
  }

  @override
  Future<User> getUser(String id) {
    return remote.getUser(id);
  }

  @override
  Future<User> updateUser({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? socialId,
    String? role,
    String? status,
    String? provider,
    String? photo,
  }) {
    // Note: The repository signature in domain/repositories/product_repository.dart
    // currently doesn't take an ID. In a real app, you'd likely want to pass an ID here!
    return remote.updateUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      provider: provider,
      socialId: socialId,
      photo: photo,
      role: role,
      status: status,
    );
  }

  @override
  Future<void> deleteUser(String id) {
    return remote.deleteUser(id);
  }
}
