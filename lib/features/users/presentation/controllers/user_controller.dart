import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../user_providers.dart';

class UserState {
  final bool isLoading;
  final User? user;
  final List<User>? users;
  final String? error;

  const UserState({this.isLoading = false, this.user, this.users, this.error});

  UserState copyWith({
    bool? isLoading,
    User? user,
    List<User>? users,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      users: users ?? this.users,
      error: error,
    );
  }
}

final userControllerProvider = NotifierProvider<UserController, UserState>(
  UserController.new,
);

class UserController extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }

  Future<void> searchUsers({String? query}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchUsersUseCase = ref.read(searchUsersUseCaseProvider);
      final usersList = await searchUsersUseCase.call(query: query);
      state = state.copyWith(isLoading: false, users: usersList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadUser(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final getUserUseCase = ref.read(getUserUseCaseProvider);
      final user = await getUserUseCase.call(id);
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> removeUser(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final deleteUserUseCase = ref.read(deleteUserUseCaseProvider);
      await deleteUserUseCase.call(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createUserUseCase = ref.read(createUserUseCaseProvider);
      final user = await createUserUseCase.call(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateUser({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateUserUseCase = ref.read(updateUserUseCaseProvider);
      final updatedUser = await updateUserUseCase.call(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      state = state.copyWith(isLoading: false, user: updatedUser);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
