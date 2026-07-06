import '../entities/warehouse.dart';

abstract class WarehouseRepository {
  Future<Warehouse> getWarehouse(String id);

  Future<List<Warehouse>> searchWarehouses({String? query});

  Future<Warehouse> createWarehouse({
    required String name,
    String? code,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    int? capacity,
    bool? hasClimateControl,
    bool? isActive,
  });

  Future<void> deleteWarehouse(String id);

  Future<Warehouse> updateWarehouse({
    required String id,
    required String name,
    String? code,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    int? capacity,
    bool? hasClimateControl,
    bool? isActive,
  });
}
