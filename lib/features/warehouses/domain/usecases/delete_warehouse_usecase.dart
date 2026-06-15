import '../repositories/warehouse_repository.dart';

class DeleteWarehouseUseCase {
  final WarehouseRepository repository;

  DeleteWarehouseUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteWarehouse(id);
  }
}
