import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<Profile> getProfile() {
    return remote.getProfile();
  }

  @override
  Future<Profile> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
  }) {
    return remote.updateProfile(
      name: name,
      phone: phone,
      avatarUrl: avatarUrl,
    );
  }
}
