import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/dependencies.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(
  LoginController.new,
);

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final loginUseCase = ref.read(loginUseCaseProvider);
      final _ = await loginUseCase.call(email, password);

      // Save token or handle user session here
      // final tokenStorage = ref.read(tokenStorageProvider);
      // await tokenStorage.saveToken("mock_token_${user.id}");

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
