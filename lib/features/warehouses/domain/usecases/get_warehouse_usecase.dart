import '../entities/warehouse.dart';
import '../repositories/warehouse_repository.dart';

class GetWarehouseUseCase {
  final WarehouseRepository repository;

  GetWarehouseUseCase(this.repository);

  Future<Warehouse> call(String id) {
    return repository.getWarehouse(id);
  }
}
