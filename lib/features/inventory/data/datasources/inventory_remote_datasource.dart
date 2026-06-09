import 'package:dio/dio.dart';
import '../models/inventory_model.dart';

class InventoryRemoteDatasource {
  final Dio dio;
  final images = [
    'https://picsum.photos/seed/product1/600/600',
    'https://picsum.photos/seed/product2/600/600',
    'https://picsum.photos/seed/product3/600/600',
    'https://picsum.photos/seed/product4/600/600',
    'https://picsum.photos/seed/product5/600/600',
  ];
  InventoryRemoteDatasource(this.dio);

  Future<List<InventoryModel>> searchInventories({String? query}) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return [
      InventoryModel(
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
      InventoryModel(
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
      InventoryModel(
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
      InventoryModel(
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
  }

  Future<InventoryModel> createInventory({
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
    return InventoryModel(
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

  Future<InventoryModel> updateInventory({
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
    return InventoryModel(
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
}
