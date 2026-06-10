import '../entities/product.dart';

abstract class ProductRepository {
  Future<Product> getProduct(String id);
 
  Future<List<Product>> searchProducts({String? query});
  Future<Product> createProduct({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  });
  Future<void> deleteProduct(String id);
  Future<Product> updateProduct({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  });
}
