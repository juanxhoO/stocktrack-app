import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Category> getCategory(String id);

  Future<List<Category>> searchCategories({String? query});
  Future<Category> createCategory({
    String? name,
    String? description,
    String? slug,
    bool? status,
    num? parentId,
    String? image,
  });
  Future<void> deleteCategory(String id);
  Future<Category> updateCategory({
    String? id,
    String? name,
    bool? status,
    String? description,
    String? slug,
    num? parentId,
    String? image,
  });
}
