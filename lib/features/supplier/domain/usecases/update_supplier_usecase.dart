import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class UpdateSupplierUseCase {
  final SupplierRepository repository;

  UpdateSupplierUseCase(this.repository);

  Future<Supplier> call({
    String? name,
    String? description,
    String? image,
    double? price,
    String? barcode,
    String? category,
    int? quantityPerUnit,
    String? unitOfMeasurement,
  }) {
    return repository.updateSupplier(
      name: name,
      description: description,
      image: image,
    );
  }
}
