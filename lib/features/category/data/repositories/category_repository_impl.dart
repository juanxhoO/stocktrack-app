import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource remote;

  CategoryRepositoryImpl(this.remote);

  @override
  Future<List<Category>> searchCategories({String? query}) {
    return remote.searchCategories(query: query);
  }

  @override
  Future<Category> getCategory(String id) {
    return remote.getCategory(id);
  }

  @override
  Future<Category> createCategory({
    String? name,
    bool? status,
    num? parentId,
    String? description,
    String? image,
    String? slug,
  }) {
    return remote.createCategory(
      name: name,
      description: description,
      slug: slug,
    );
  }

  @override
  Future<Category> updateCategory({
    String? id,
    bool? status,
    String? name,
    num? parentId,
    String? description,
    String? slug,
    String? image,
  }) {
    return remote.updateCategory(
      id: id,
      name: name,
      description: description,
      slug: slug,
    );
  }

  @override
  Future<void> deleteCategory(String id) {
    return remote.deleteCategory(id);
  }
}
