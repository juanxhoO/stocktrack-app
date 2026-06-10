import '../../domain/entities/inventory.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../datasources/inventory_remote_datasource.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDatasource remote;

  InventoryRepositoryImpl(this.remote);

  @override
  Future<List<Inventory>> searchInventories({String? query}) {
    return remote.searchInventories(query: query);
  }

  @override
  Future<Inventory> createInventory({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    return remote.createInventory(
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

  @override
  Future<Inventory> updateInventory({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    // Note: The repository signature in domain/repositories/product_repository.dart
    // currently doesn't take an ID. In a real app, you'd likely want to pass an ID here!
    return remote.updateInventory(
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
