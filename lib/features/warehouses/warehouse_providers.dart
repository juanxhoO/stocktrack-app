import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/dependencies.dart';
import 'data/datasources/warehouse_remote_datasource.dart';
import 'data/repositories/warehouse_repository_impl.dart';
import 'domain/repositories/warehouse_repository.dart';
import 'domain/usecases/create_warehouse_usecase.dart';
import 'domain/usecases/delete_warehouse_usecase.dart';
import 'domain/usecases/get_warehouse_usecase.dart';
import 'domain/usecases/search_warehouses_usecase.dart';
import 'domain/usecases/update_warehouse_usecase.dart';

final warehouseRemoteDatasourceProvider = Provider<WarehouseRemoteDatasource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return WarehouseRemoteDatasource(dioClient.dio);
});

final warehouseRepositoryProvider = Provider<WarehouseRepository>((ref) {
  final remoteDatasource = ref.watch(warehouseRemoteDatasourceProvider);
  return WarehouseRepositoryImpl(remoteDatasource);
});

final getWarehouseUseCaseProvider = Provider<GetWarehouseUseCase>((ref) {
  final repository = ref.watch(warehouseRepositoryProvider);
  return GetWarehouseUseCase(repository);
});

final deleteWarehouseUseCaseProvider = Provider<DeleteWarehouseUseCase>((ref) {
  final repository = ref.watch(warehouseRepositoryProvider);
  return DeleteWarehouseUseCase(repository);
});

final searchWarehousesUseCaseProvider = Provider<SearchWarehousesUseCase>((
  ref,
) {
  final repository = ref.watch(warehouseRepositoryProvider);
  return SearchWarehousesUseCase(repository);
});

final createWarehouseUseCaseProvider = Provider<CreateWarehouseUseCase>((ref) {
  final repository = ref.watch(warehouseRepositoryProvider);
  return CreateWarehouseUseCase(repository);
});

final updateWarehouseUseCaseProvider = Provider<UpdateWarehouseUseCase>((ref) {
  final repository = ref.watch(warehouseRepositoryProvider);
  return UpdateWarehouseUseCase(repository);
});
