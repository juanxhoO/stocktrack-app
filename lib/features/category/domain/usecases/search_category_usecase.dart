import '../entities/category.dart';
import '../repositories/category_repository.dart';

class SearchCategoriesUseCase {
  final CategoryRepository repository;

  SearchCategoriesUseCase(this.repository);

  Future<List<Category>> call({String? query}) {
    return repository.searchCategories(query: query);
  }
}
