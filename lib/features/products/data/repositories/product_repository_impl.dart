import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remote;

  ProductRepositoryImpl(this.remote);

  @override
  Future<List<Product>> searchProducts({String? query}) {
    return remote.searchProducts(query: query);
  }

  Future<Product> getProduct(String id) {
    return remote.getProduct(id);
  }

  @override
  Future<Product> createProduct({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    return remote.createProduct(
      name: name,
      description: description,
      image: image,
      price: price,
      barcode: barcode,
      category: category,
      quantityPerUnit: quantityPerUnit,
      unitOfMeasurement: unitOfMeasurement,
    );
  }

  @override
  Future<Product> updateProduct({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    // Note: The repository signature in domain/repositories/product_repository.dart 
    // currently doesn't take an ID. In a real app, you'd likely want to pass an ID here!
    return remote.updateProduct(
      name: name,
      description: description,
      image: image,
      price: price,
      barcode: barcode,
      category: category,
      quantityPerUnit: quantityPerUnit,
      unitOfMeasurement: unitOfMeasurement,
    );
  }

  @override
  Future<void> deleteProduct(String id) {
    return remote.deleteProduct(id);
  }
}
