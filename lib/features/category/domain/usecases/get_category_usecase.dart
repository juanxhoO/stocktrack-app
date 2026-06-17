import '../entities/category.dart';
import '../repositories/category_repository.dart';

class GetCategoryUseCase {
  final CategoryRepository repository;

  GetCategoryUseCase(this.repository);

  Future<Category> call(String id) {
    return repository.getCategory(id);
  }
}
