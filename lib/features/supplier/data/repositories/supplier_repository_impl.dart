import '../../domain/entities/supplier.dart';
import '../../domain/repositories/supplier_repository.dart';
import '../datasources/supplier_remote_datasource.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final SupplierRemoteDatasource remote;

  SupplierRepositoryImpl(this.remote);

  @override
  Future<List<Supplier>> searchSuppliers({String? query}) {
    return remote.searchSuppliers(query: query);
  }

  Future<Supplier> getSupplier(String id) {
    return remote.getSupplier(id);
  }

  @override
  Future<Supplier> createSupplier({
    String? name,
    String? description,
    String? image,
  }) {
    return remote.createSupplier(
      name: name,
      description: description,
      image: image,
    );
  }

  @override
  Future<Supplier> updateSupplier({
    String? id,
    String? name,
    String? description,
    String? image,
  }) {
    return remote.updateSupplier(
      id: id,
      name: name,
      description: description,
      image: image,
    );
  }

  @override
  Future<void> deleteSupplier(String id) {
    return remote.deleteSupplier(id);
  }
}
