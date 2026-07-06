import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchUsersUseCase {
  final UserRepository userRepository;

  SearchUsersUseCase(this.userRepository);

  Future<List<User>> call({String? query}) {
    return userRepository.searchUsers(query: query);
  }
}
