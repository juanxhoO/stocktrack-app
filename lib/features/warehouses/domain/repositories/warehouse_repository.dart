import '../entities/warehouse.dart';

abstract class WarehouseRepository {
  Future<Warehouse> getWarehouse(String id);

  Future<List<Warehouse>> searchWarehouses({String? query});
  Future<Warehouse> createWarehouse({
    String? name,
    String? description,
    String? image,
  });
  Future<void> deleteWarehouse(String id);
  Future<Warehouse> updateWarehouse({
    String? name,
    String? description,
    String? image,
  });
}
