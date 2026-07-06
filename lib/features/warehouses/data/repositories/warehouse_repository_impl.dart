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

  @override
  Future<Warehouse> getWarehouse(String id) {
    return remote.getWarehouse(id);
  }

  @override
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
  }) {
    return remote.createWarehouse(
      name: name,
      code: code,
      phone: phone,
      address: address,
      city: city,
      state: state,
      country: country,
      zipCode: zipcode,
      capacity: capacity,
      hasClimateControl: hasClimateControl,
      isActive: isActive,
    );
  }

  @override
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
  }) {
    return remote.updateWarehouse(
      id: id,
      name: name,
      code: code,
      phone: phone,
      address: address,
      city: city,
      state: state,
      country: country,
      zipCode: zipcode,
      capacity: capacity,
      hasClimateControl: hasClimateControl,
      isActive: isActive,
    );
  }

  @override
  Future<void> deleteWarehouse(String id) {
    return remote.deleteWarehouse(id);
  }
}
