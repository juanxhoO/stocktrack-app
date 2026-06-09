import '../../domain/entities/inventory.dart';

class InventoryModel extends Inventory {
  const InventoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.price,
    required super.barcode,
    required super.category,
    required super.quantityPerUnit,
    required super.unitOfMeasurement,
    required super.createdAt,
    required super.updatedAt,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      price: (json['price'] as num).toDouble(),
      barcode: json['barcode'] as String?,
      category: json['category'] as String,
      quantityPerUnit: json['quantityPerUnit'] as int,
      unitOfMeasurement: json['unitOfMeasurement'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'barcode': barcode,
      'category': category,
      'quantityPerUnit': quantityPerUnit,
      'unitOfMeasurement': unitOfMeasurement,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
