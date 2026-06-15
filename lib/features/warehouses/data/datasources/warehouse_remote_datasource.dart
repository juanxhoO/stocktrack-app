import 'package:dio/dio.dart';
import '../models/warehouse_model.dart';

class WarehouseRemoteDatasource {
  final Dio dio;
  final images = [
    'https://picsum.photos/seed/product1/600/600',
    'https://picsum.photos/seed/product2/600/600',
    'https://picsum.photos/seed/product3/600/600',
    'https://picsum.photos/seed/product4/600/600',
    'https://picsum.photos/seed/product5/600/600',
  ];
  WarehouseRemoteDatasource(this.dio);

  Future<List<WarehouseModel>> searchWarehouses({String? query}) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return [
      WarehouseModel(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium noise cancelling headphones.',
        address: '123 Main St',
        capacity: 100,
        city: 'New York',
        status: true,
        state: 'NY',
        country: 'USA',
        zipCode: '10001',
        phoneNumber: '1234567890',
        email: 'juan@email.com',
        image: images[0],
        createdAt: '2023-10-01T00:00:00.000Z',
        updatedAt: '2023-10-01T00:00:00.000Z',
      ),
    ];
  }

  Future<WarehouseModel> getWarehouse(String id) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return const WarehouseModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://example.com/image.jpg',
      address: '123 Main St',
      capacity: 100,
      city: 'New York',
      status: true,
      state: 'NY',
      country: 'USA',
      zipCode: '10001',
      phoneNumber: '1234567890',
      email: 'juan@email.com',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    );
  }

  Future<WarehouseModel> createWarehouse({
    String? name,
    String? description,
    String? image,
    String? address,
    int? capacity,
    String? city,
    bool? status,
    String? state,
    String? country,
    String? zipCode,
    String? phoneNumber,
    String? email,
  }) async {
    // In a real app:
    // final response = await dio.post('/products', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return WarehouseModel(
      id: '124',
      name: name ?? 'New Product',
      description: description ?? 'New Description',
      image: image ?? 'https://example.com/image.jpg',
      address: address ?? 'New Address',
      capacity: capacity ?? 100,
      city: city ?? 'New City',
      status: status ?? true,
      state: state ?? 'New State',
      country: country ?? 'New Country',
      zipCode: zipCode ?? 'New Zip Code',
      phoneNumber: phoneNumber ?? 'New Phone Number',
      email: email ?? 'New Email',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<WarehouseModel> updateWarehouse({
    String? id,
    String? name,
    String? description,
    String? image,
  }) async {
    // In a real app:
    // final response = await dio.put('/products/$id', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return WarehouseModel(
      id: id ?? '123',
      name: name ?? 'Updated Product',
      description: description ?? 'Updated Description',
      image: image ?? 'https://example.com/image.jpg',
      address: '123 Main St',
      capacity: 100,
      city: 'New York',
      status: true,
      state: 'NY',
      country: 'USA',
      zipCode: '10001',
      phoneNumber: '1234567890',
      email: 'juan@email.com',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<void> deleteWarehouse(String id) async {
    // In a real app:
    // await dio.delete('/products/$id');

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
  }
}
