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
    try {
      final response = await dio.get(
        '/warehouses',
        queryParameters: {'name': query},
      );
      return List<WarehouseModel>.from(
        response.data['data'].map((x) => WarehouseModel.fromJson(x)),
      );
    } on DioException catch (e) {
      // Handle specific API errors, e.g., 401 Unauthorized
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      }
      if (e.response?.statusCode == 422) {
        throw Exception(e.response?.data['errors'].toString());
      }
      throw Exception(e.response?.data['errors'].toString());
    }
  }

  Future<WarehouseModel> getWarehouse(String id) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return const WarehouseModel(
      id: 123,
      name: 'Sample Product',
      address: '123 Main St',
      capacity: 100,
      city: 'New York',
      hasClimateControl: false,
      manager: {"id": 7, "role": null, "status": null},
      isActive: true,
      state: 'NY',
      country: 'USA',
      zipcode: '10001',
      phone: '1234567890',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
      deletedAt: null,
    );
  }

  Future<WarehouseModel> createWarehouse({
    String? name,
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
      id: 124,
      name: name ?? 'New Product',
      address: address ?? 'New Address',
      capacity: capacity ?? 100,
      hasClimateControl: false,
      city: city ?? 'New City',
      manager: {"id": 7, "role": null, "status": null},
      isActive: status ?? true,
      state: state ?? 'New State',
      country: country ?? 'New Country',
      zipcode: zipCode ?? 'New Zip Code',
      phone: phoneNumber ?? 'New Phone Number',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      deletedAt: null,
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
      id: 123,
      name: name ?? 'Updated Product',
      address: '123 Main St',
      hasClimateControl: true,
      capacity: 100,
      city: 'New York',
      manager: {"id": 7, "role": null, "status": null},
      isActive: true,
      state: 'NY',
      country: 'USA',
      zipcode: '10001',
      phone: '1234567890',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: DateTime.now().toIso8601String(),
      deletedAt: null,
    );
  }

  Future<void> deleteWarehouse(String id) async {
    // In a real app:
    // await dio.delete('/products/$id');

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
  }
}
