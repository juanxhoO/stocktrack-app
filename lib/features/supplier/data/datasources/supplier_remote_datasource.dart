import 'package:dio/dio.dart';
import '../models/supplier_model.dart';

class SupplierRemoteDatasource {
  final Dio dio;
  final images = [
    'https://picsum.photos/seed/product1/600/600',
    'https://picsum.photos/seed/product2/600/600',
    'https://picsum.photos/seed/product3/600/600',
    'https://picsum.photos/seed/product4/600/600',
    'https://picsum.photos/seed/product5/600/600',
  ];
  SupplierRemoteDatasource(this.dio);

  Future<List<SupplierModel>> searchSuppliers({String? query}) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return [
      SupplierModel(
        id: '1',
        name: 'Wireless Headphones',
        description: 'Premium noise cancelling headphones.',
        image: images[0],
        createdAt: '2023-10-01T00:00:00.000Z',
        updatedAt: '2023-10-01T00:00:00.000Z',
        productsCount: 10,
        status: true,
      ),
    ];
  }

  Future<SupplierModel> getSupplier(String id) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return const SupplierModel(
      id: '1',
      name: 'Wireless Headphones',
      description: 'Premium noise cancelling headphones.',
      image: 'https://example.com/image.jpg',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
      productsCount: 10,
      status: true,
    );
  }

  Future<SupplierModel> createSupplier({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) async {
    // In a real app:
    // final response = await dio.post('/products', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return SupplierModel(
      id: '124',
      name: name ?? 'New Product',
      description: description ?? 'New Description',
      image: image,
      productsCount: 10,
      status: true,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<SupplierModel> updateSupplier({
    String? id,
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) async {
    // In a real app:
    // final response = await dio.put('/products/$id', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return SupplierModel(
      id: id ?? '123',
      name: name ?? 'Updated Product',
      description: description ?? 'Updated Description',
      image: image,
      productsCount: 10,
      status: true,
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<void> deleteSupplier(String id) async {
    // In a real app:
    // await dio.delete('/products/$id');

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
  }
}
