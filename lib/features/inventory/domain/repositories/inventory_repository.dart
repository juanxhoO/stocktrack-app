import '../entities/inventory.dart';

abstract class InventoryRepository {
  Future<List<Inventory>> searchInventories({String? query});
  Future<Inventory> createInventory({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  });
  Future<Inventory> updateInventory({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  });
}
