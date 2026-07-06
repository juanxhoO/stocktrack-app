import '../../domain/entities/warehouse.dart';

class WarehouseModel extends Warehouse {
  const WarehouseModel({
    required super.id,
    required super.name,
    required super.address,
    required super.hasClimateControl,
    required super.capacity,
    required super.city,
    required super.isActive,
    required super.state,
    required super.country,
    required super.manager,
    required super.zipcode,
    required super.phone,
    required super.createdAt,
    required super.updatedAt,
    required super.deletedAt,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      id: json['id'] as num,
      name: json['name'] as String,
      address: json['address'] as String,
      capacity: json['capacity'] as num?,
      hasClimateControl: json['hasClimateControl'] as bool,
      city: json['city'] as String,
      isActive: json['isActive'] as bool,
      state: json['state'] as String,
      country: json['country'] as String,
      zipcode: json['zipcode'] as String,
      phone: json['phone'] as String,
      manager: json['manager'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'capacity': capacity,
      'city': city,
      'isActive': isActive,
      'hasClimateControl': hasClimateControl,
      'manager': manager,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'phone': phone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
