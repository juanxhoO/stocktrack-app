import '../entities/warehouse.dart';
import '../repositories/warehouse_repository.dart';

class UpdateWarehouseUseCase {
  final WarehouseRepository repository;

  UpdateWarehouseUseCase(this.repository);

  Future<Warehouse> call({String? name, String? description, String? image}) {
    return repository.updateWarehouse(
      name: name,
      description: description,
      image: image,
    );
  }
}
