import '../entities/warehouse.dart';
import '../repositories/warehouse_repository.dart';

class CreateWarehouseUseCase {
  final WarehouseRepository repository;

  CreateWarehouseUseCase(this.repository);

  Future<Warehouse> call({String? name, String? description, String? image}) {
    return repository.createWarehouse(
      name: name,
      description: description,
      image: image,
    );
  }
}
