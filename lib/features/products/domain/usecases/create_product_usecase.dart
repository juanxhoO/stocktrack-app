import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository repository;

  CreateProductUseCase(this.repository);

  Future<Product> call({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    return repository.createProduct(
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
}
