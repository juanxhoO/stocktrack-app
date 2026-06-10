class Inventory {
  final String id;
  final String name;
  final String description;
  final String? image;
  final double price;
  final String? barcode;
  final String category;
  final int quantityPerUnit;
  final String? unitOfMeasurement;
  final String? createdAt;
  final String? updatedAt;

  const Inventory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.barcode,
    required this.category,
    required this.quantityPerUnit,
    required this.unitOfMeasurement,
    required this.createdAt,
    required this.updatedAt,
  });
}
