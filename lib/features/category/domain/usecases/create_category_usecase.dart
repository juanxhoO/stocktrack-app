import '../entities/category.dart';
import '../repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<Category> call({String? name, String? description, String? image}) {
    return repository.createCategory(
      name: name,
      description: description,
      image: image,
    );
  }
}
