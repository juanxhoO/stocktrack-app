import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductRemoteDatasource {
  final Dio dio;

  ProductRemoteDatasource(this.dio);

  Future<List<ProductModel>> searchProducts({String? query}) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return [
      ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://example.com/image.jpg',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    ),
    ];
  }



  Future<ProductModel> getProduct(String id) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return const ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://example.com/image.jpg',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    );
  }

  Future<ProductModel> createProduct({
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
    return ProductModel(
      id: '124',
      name: name ?? 'New Product',
      description: description ?? 'New Description',
      image: image,
      price: price ?? 0.0,
      barcode: barcode,
      category: category ?? 'General',
      quantityPerUnit: quantityPerUnit ?? 1,
      unitOfMeasurement: unitOfMeasurement,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<ProductModel> updateProduct({
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
    return ProductModel(
      id: id ?? '123',
      name: name ?? 'Updated Product',
      description: description ?? 'Updated Description',
      image: image,
      price: price ?? 0.0,
      barcode: barcode,
      category: category ?? 'General',
      quantityPerUnit: quantityPerUnit ?? 1,
      unitOfMeasurement: unitOfMeasurement,
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<void> deleteProduct(String id) async {
    // In a real app:
    // await dio.delete('/products/$id');
    
    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
  }
}
