import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class CreateSupplierUseCase {
  final SupplierRepository repository;

  CreateSupplierUseCase(this.repository);

  Future<Supplier> call({String? name, String? description, String? image}) {
    return repository.createSupplier(
      name: name,
      description: description,
      image: image,
    );
  }
}
