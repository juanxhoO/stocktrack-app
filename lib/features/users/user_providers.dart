import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/dependencies.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/create_user_usecase.dart';
import 'domain/usecases/delete_user_usecase.dart';
import 'domain/usecases/get_user_usecase.dart';
import 'domain/usecases/search_users_usecase.dart';
import 'domain/usecases/update_user_usecase.dart';

final userRemoteDatasourceProvider = Provider<UserRemoteDatasource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserRemoteDatasource(dioClient.dio);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDatasource = ref.watch(userRemoteDatasourceProvider);
  return UserRepositoryImpl(remoteDatasource);
});

final searchUsersUseCaseProvider = Provider<SearchUsersUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return SearchUsersUseCase(repository);
});

final deleteUserUseCaseProvider = Provider<DeleteUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return DeleteUserUseCase(repository);
});

final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUseCase(repository);
});

final createUserUseCaseProvider = Provider<CreateUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return CreateUserUseCase(repository);
});

final updateUserUseCaseProvider = Provider<UpdateUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateUserUseCase(repository);
});
