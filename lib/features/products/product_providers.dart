import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/dependencies.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/create_product_usecase.dart';
import 'domain/usecases/delete_product_usecase.dart';
import 'domain/usecases/get_product_usecase.dart';
import 'domain/usecases/search_products_usecase.dart';
import 'domain/usecases/update_product_usecase.dart';

final productRemoteDatasourceProvider = Provider<ProductRemoteDatasource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return ProductRemoteDatasource(dioClient.dio);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDatasource = ref.watch(productRemoteDatasourceProvider);
  return ProductRepositoryImpl(remoteDatasource);
});

final getProductUseCaseProvider = Provider<GetProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return GetProductUseCase(repository);
});

final deleteProductUseCaseProvider = Provider<DeleteProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return DeleteProductUseCase(repository);
});

final searchProductsUseCaseProvider = Provider<SearchProductsUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return SearchProductsUseCase(repository);
});

final createProductUseCaseProvider = Provider<CreateProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return CreateProductUseCase(repository);
});

final updateProductUseCaseProvider = Provider<UpdateProductUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return UpdateProductUseCase(repository);
});
