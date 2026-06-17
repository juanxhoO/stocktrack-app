import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/dependencies.dart';
import 'data/datasources/inventory_remote_datasource.dart';
import 'data/repositories/inventory_repository_impl.dart';
import 'domain/repositories/inventory_repository.dart';
import 'domain/usecases/create_inventory_usecase.dart';
import 'domain/usecases/search_inventories_usecase.dart';
import 'domain/usecases/update_inventory_usecase.dart';

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
