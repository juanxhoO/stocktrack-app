import '../entities/warehouse.dart';
import '../repositories/warehouse_repository.dart';

class UpdateWarehouseUseCase {
  final WarehouseRepository repository;

  UpdateWarehouseUseCase(this.repository);

  Future<Warehouse> call({
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
    return repository.updateWarehouse(
      id: id,
      name: name,
      code: code,
      phone: phone,
      address: address,
      city: city,
      state: state,
      country: country,
      zipcode: zipcode,
      capacity: capacity,
      hasClimateControl: hasClimateControl,
      isActive: isActive,
    );
  }
}
