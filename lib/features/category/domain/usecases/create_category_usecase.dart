import '../entities/category.dart';
import '../repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepository repository;

  CreateCategoryUseCase(this.repository);

  Future<Category> call({
    String? name,
    String? description,
    String? slug,
    bool? status,
    num? parentId,
    String? image,
  }) {
    return repository.createCategory(
      name: name,
      description: description,
      slug: slug,
      status: status,
      parentId: parentId,
      image: image,
    );
  }
}
