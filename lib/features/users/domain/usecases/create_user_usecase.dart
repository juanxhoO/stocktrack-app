import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  Future<User> call({
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
  }) {
    return repository.createUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      photo: photo,
      socialId: socialId,
      role: role,
      status: status,
    );
  }
}
