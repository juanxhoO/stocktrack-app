import '../../domain/entities/supplier.dart';

class SupplierModel extends Supplier {
  const SupplierModel({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
    required super.productsCount,
    required super.status,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      productsCount: json['productsCount'] as int,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
