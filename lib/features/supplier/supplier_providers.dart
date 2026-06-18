import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/providers/dependencies.dart';
import 'data/datasources/supplier_remote_datasource.dart';
import 'data/repositories/supplier_repository_impl.dart';
import 'domain/repositories/supplier_repository.dart';
import 'domain/usecases/create_supplier_usecase.dart';
import 'domain/usecases/delete_supplier_usecase.dart';
import 'domain/usecases/get_supplier_usecase.dart';
import 'domain/usecases/search_supplier_usecase.dart';
import 'domain/usecases/update_supplier_usecase.dart';

final supplierRemoteDatasourceProvider = Provider<SupplierRemoteDatasource>((
  ref,
) {
  final dioClient = ref.watch(dioClientProvider);
  return SupplierRemoteDatasource(dioClient.dio);
});

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  final remoteDatasource = ref.watch(supplierRemoteDatasourceProvider);
  return SupplierRepositoryImpl(remoteDatasource);
});

final getSupplierUseCaseProvider = Provider<GetSupplierUseCase>((ref) {
  final repository = ref.watch(supplierRepositoryProvider);
  return GetSupplierUseCase(repository);
});

final deleteSupplierUseCaseProvider = Provider<DeleteSupplierUseCase>((ref) {
  final repository = ref.watch(supplierRepositoryProvider);
  return DeleteSupplierUseCase(repository);
});

final searchSuppliersUseCaseProvider = Provider<SearchSuppliersUseCase>((ref) {
  final repository = ref.watch(supplierRepositoryProvider);
  return SearchSuppliersUseCase(repository);
});

final createSupplierUseCaseProvider = Provider<CreateSupplierUseCase>((ref) {
  final repository = ref.watch(supplierRepositoryProvider);
  return CreateSupplierUseCase(repository);
});

final updateSupplierUseCaseProvider = Provider<UpdateSupplierUseCase>((ref) {
  final repository = ref.watch(supplierRepositoryProvider);
  return UpdateSupplierUseCase(repository);
});
