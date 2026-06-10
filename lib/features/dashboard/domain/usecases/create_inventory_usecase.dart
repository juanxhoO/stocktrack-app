import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class CreateInventoryUseCase {
  final InventoryRepository repository;

  CreateInventoryUseCase(this.repository);

  Future<Inventory> call({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    return repository.createInventory(
      name: name,
      description: description,
      image: image,
      price: price,
      barcode: barcode,
      category: category,
      quantityPerUnit: quantityPerUnit,
      unitOfMeasurement: unitOfMeasurement,
    );
  }
}
