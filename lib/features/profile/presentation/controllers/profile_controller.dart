import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile.dart';
import '../../profile_providers.dart';

class ProfileState {
  final bool isLoading;
  final Profile? profile;
  final String? error;

  const ProfileState({
    this.isLoading = false,
    this.profile,
    this.error,
  });

  ProfileState copyWith({
    bool? isLoading,
    Profile? profile,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      error: error,
    );
  }
}

final profileControllerProvider =
    NotifierProvider<ProfileController, ProfileState>(
  ProfileController.new,
);

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    return const ProfileState();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final getProfileUseCase = ref.read(getProfileUseCaseProvider);
      final profile = await getProfileUseCase.call();
      state = state.copyWith(isLoading: false, profile: profile);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateProfileUseCase = ref.read(updateProfileUseCaseProvider);
      final updatedProfile = await updateProfileUseCase.call(
        name: name,
        phone: phone,
        avatarUrl: avatarUrl,
      );
      state = state.copyWith(isLoading: false, profile: updatedProfile);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
