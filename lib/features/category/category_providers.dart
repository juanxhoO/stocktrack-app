import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/dependencies.dart';
import 'data/datasources/category_remote_datasource.dart';
import 'data/repositories/category_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/usecases/create_category_usecase.dart';
import 'domain/usecases/delete_category_usecase.dart';
import 'domain/usecases/get_category_usecase.dart';
import 'domain/usecases/search_category_usecase.dart';
import 'domain/usecases/update_category_usecase.dart';

final categoryRemoteDatasourceProvider = Provider<CategoryRemoteDatasource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return CategoryRemoteDatasource(dioClient.dio);
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final remoteDatasource = ref.watch(categoryRemoteDatasourceProvider);
  return CategoryRepositoryImpl(remoteDatasource);
});

final getCategoryUseCaseProvider = Provider<GetCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return GetCategoryUseCase(repository);
});

final deleteCategoryUseCaseProvider = Provider<DeleteCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return DeleteCategoryUseCase(repository);
});

final searchCategoriesUseCaseProvider = Provider<SearchCategoriesUseCase>((
  ref,
) {
  final repository = ref.watch(categoryRepositoryProvider);
  return SearchCategoriesUseCase(repository);
});

final createCategoryUseCaseProvider = Provider<CreateCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return CreateCategoryUseCase(repository);
});

final updateCategoryUseCaseProvider = Provider<UpdateCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return UpdateCategoryUseCase(repository);
});
