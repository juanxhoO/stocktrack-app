import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Profile> call({
    String? name,
    String? phone,
    String? avatarUrl,
  }) {
    return repository.updateProfile(
      name: name,
      phone: phone,
      avatarUrl: avatarUrl,
    );
  }
}
