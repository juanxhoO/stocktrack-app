import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  Future<User> call({
    String? id,
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
    return repository.updateUser(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      photo: photo,
      socialId: socialId,
      role: role,
      status: status,
      provider: provider,
    );
  }
}
