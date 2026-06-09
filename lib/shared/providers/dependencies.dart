import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/token_storage.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/products/data/datasources/product_remote_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/search_products_usecase.dart';
import '../../features/products/domain/usecases/create_product_usecase.dart';
import '../../features/products/domain/usecases/update_product_usecase.dart';
import '../../features/products/domain/usecases/get_product_usecase.dart';
import '../../features/products/domain/usecases/delete_product_usecase.dart';
import '../../features/inventory/domain/usecases/search_inventories_usecase.dart';
import '../../features/inventory/domain/usecases/create_inventory_usecase.dart';
import '../../features/inventory/domain/usecases/update_inventory_usecase.dart';
import '../../features/inventory/data/datasources/inventory_remote_datasource.dart';
import '../../features/inventory/domain/repositories/inventory_repository.dart';
import '../../features/inventory/data/repositories/inventory_repository_impl.dart';

// --- Core Providers ---

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Initialized in main.dart
});

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TokenStorage(prefs);
});

// --- Auth Feature Providers ---

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRemoteDatasource(dioClient.dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDatasource = ref.watch(authRemoteDatasourceProvider);
  return AuthRepositoryImpl(remoteDatasource);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

// --- Profile Feature Providers ---

final profileRemoteDatasourceProvider = Provider<ProfileRemoteDatasource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return ProfileRemoteDatasource(dioClient.dio);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDatasource = ref.watch(profileRemoteDatasourceProvider);
  return ProfileRepositoryImpl(remoteDatasource);
});

final getProfileUseCaseProvider = Provider<GetProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return GetProfileUseCase(repository);
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UpdateProfileUseCase(repository);
});

// --- Products Feature Providers ---

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

// --- Inventory Feature Providers ---

final inventoryRemoteDatasourceProvider = Provider<InventoryRemoteDatasource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return InventoryRemoteDatasource(dioClient.dio);
});

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final remoteDatasource = ref.watch(inventoryRemoteDatasourceProvider);
  return InventoryRepositoryImpl(remoteDatasource);
});

final searchInventoriesUseCaseProvider = Provider<SearchInventoriesUseCase>((
  ref,
) {
  final repository = ref.watch(inventoryRepositoryProvider);
  return SearchInventoriesUseCase(repository);
});

final createInventoryUseCaseProvider = Provider<CreateInventoryUseCase>((ref) {
  final repository = ref.watch(inventoryRepositoryProvider);
  return CreateInventoryUseCase(repository);
});

final updateInventoryUseCaseProvider = Provider<UpdateInventoryUseCase>((ref) {
  final repository = ref.watch(inventoryRepositoryProvider);
  return UpdateInventoryUseCase(repository);
});
