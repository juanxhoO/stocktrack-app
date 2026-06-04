import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductRemoteDatasource {
  final Dio dio;
final images = [
  'https://picsum.photos/seed/product1/600/600',
  'https://picsum.photos/seed/product2/600/600',
  'https://picsum.photos/seed/product3/600/600',
  'https://picsum.photos/seed/product4/600/600',
  'https://picsum.photos/seed/product5/600/600',
];
  ProductRemoteDatasource(this.dio);

  Future<List<ProductModel>> searchProducts({String? query}) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
<<<<<<< Updated upstream
    return [
      ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    ),
          ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    ),
          ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    ),
          ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    ),
          ProductModel(
      id: '123',
      name: 'Sample Product',
      description: 'A mock description for our product.',
      image: 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
      price: 19.99,
      barcode: '1234567890123',
      category: 'Electronics',
      quantityPerUnit: 1,
      unitOfMeasurement: 'Piece',
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    ),
    ];
=======
   return [
  ProductModel(
    id: '1',
    name: 'Wireless Headphones',
    description: 'Premium noise cancelling headphones.',
    image: images[0],
    price: 89.99,
    barcode: '1234567890123',
    category: 'Electronics',
    quantityPerUnit: 1,
    unitOfMeasurement: 'Piece',
    createdAt: '2023-10-01T00:00:00.000Z',
    updatedAt: '2023-10-01T00:00:00.000Z',
  ),
  ProductModel(
    id: '2',
    name: 'Gaming Mouse',
    description: 'RGB gaming mouse.',
    image: images[1],
    price: 39.99,
    barcode: '1234567890124',
    category: 'Electronics',
    quantityPerUnit: 1,
    unitOfMeasurement: 'Piece',
    createdAt: '2023-10-01T00:00:00.000Z',
    updatedAt: '2023-10-01T00:00:00.000Z',
  ),
  ProductModel(
    id: '3',
    name: 'Mechanical Keyboard',
    description: 'Blue switch mechanical keyboard.',
    image: images[2],
    price: 79.99,
    barcode: '1234567890125',
    category: 'Electronics',
    quantityPerUnit: 1,
    unitOfMeasurement: 'Piece',
    createdAt: '2023-10-01T00:00:00.000Z',
    updatedAt: '2023-10-01T00:00:00.000Z',
  ),
  ProductModel(
    id: '4',
    name: 'Office Chair',
    description: 'Ergonomic office chair.',
    image: images[3],
    price: 149.99,
    barcode: '1234567890126',
    category: 'Furniture',
    quantityPerUnit: 1,
    unitOfMeasurement: 'Piece',
    createdAt: '2023-10-01T00:00:00.000Z',
    updatedAt: '2023-10-01T00:00:00.000Z',
  ),
];
>>>>>>> Stashed changes
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
