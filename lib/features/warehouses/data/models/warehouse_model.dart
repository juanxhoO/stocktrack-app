import '../../domain/entities/warehouse.dart';

class WarehouseModel extends Warehouse {
  const WarehouseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    required super.capacity,
    required super.city,
    required super.status,
    required super.state,
    required super.country,
    required super.zipCode,
    required super.phoneNumber,
    required super.email,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      capacity: json['capacity'] as num,
      city: json['city'] as String,
      status: json['status'] as bool,
      state: json['state'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'capacity': capacity,
      'city': city,
      'status': status,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'phoneNumber': phoneNumber,
      'email': email,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
