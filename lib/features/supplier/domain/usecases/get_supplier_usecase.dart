import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class GetSupplierUseCase {
  final SupplierRepository repository;

  GetSupplierUseCase(this.repository);

  Future<Supplier> call(String id) {
    return repository.getSupplier(id);
  }
}
