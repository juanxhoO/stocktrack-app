import '../../domain/entities/warehouse.dart';
import '../../domain/repositories/warehouse_repository.dart';
import '../datasources/warehouse_remote_datasource.dart';

class WarehouseRepositoryImpl implements WarehouseRepository {
  final WarehouseRemoteDatasource remote;

  WarehouseRepositoryImpl(this.remote);

  @override
  Future<List<Warehouse>> searchWarehouses({String? query}) {
    return remote.searchWarehouses(query: query);
  }

  Future<Warehouse> getWarehouse(String id) {
    return remote.getWarehouse(id);
  }

  @override
  Future<Warehouse> createWarehouse({
    String? name,
    String? description,
    String? image,
  }) {
    return remote.createWarehouse(name: name, image: image);
  }

  @override
  Future<Warehouse> updateWarehouse({
    String? name,
    String? description,
    String? image,
  }) {
    // Note: The repository signature in domain/repositories/product_repository.dart
    // currently doesn't take an ID. In a real app, you'd likely want to pass an ID here!
    return remote.updateWarehouse(
      name: name,
      description: description,
      image: image,
    );
  }

  @override
  Future<void> deleteWarehouse(String id) {
    return remote.deleteWarehouse(id);
  }
}
