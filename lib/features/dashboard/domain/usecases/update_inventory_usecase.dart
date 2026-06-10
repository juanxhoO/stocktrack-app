import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class UpdateInventoryUseCase {
  final InventoryRepository repository;

  UpdateInventoryUseCase(this.repository);

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
    return repository.updateInventory(
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
