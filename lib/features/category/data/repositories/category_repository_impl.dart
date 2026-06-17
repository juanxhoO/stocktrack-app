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

  Future<Category> getCategory(String id) {
    return remote.getCategory(id);
  }

  @override
  Future<Category> createCategory({
    String? name,
    String? description,
    String? image,
  }) {
    return remote.createCategory(
      name: name,
      description: description,
      image: image,
    );
  }

  @override
  Future<Category> updateCategory({
    String? name,
    String? description,
    String? image,
  }) {
    return remote.updateCategory(
      name: name,
      description: description,
      image: image,
    );
  }

  @override
  Future<void> deleteCategory(String id) {
    return remote.deleteCategory(id);
  }
}
