import '../entities/category.dart';
import '../repositories/category_repository.dart';

class UpdateCategoryUseCase {
  final CategoryRepository repository;

  UpdateCategoryUseCase(this.repository);

  Future<Category> call({
    String? id,
    String? name,
    bool? status,
    num? parentId,
    String? slug,
    String? description,
  }) {
    return repository.updateCategory(
      id: id,
      name: name,
      status: status,
      parentId: parentId,
      slug: slug,
      description: description,
    );
  }
}
