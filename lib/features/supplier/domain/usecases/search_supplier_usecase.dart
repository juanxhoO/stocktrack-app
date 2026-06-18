import '../entities/supplier.dart';
import '../repositories/supplier_repository.dart';

class SearchSuppliersUseCase {
  final SupplierRepository repository;

  SearchSuppliersUseCase(this.repository);

  Future<List<Supplier>> call({String? query}) {
    return repository.searchSuppliers(query: query);
  }
}
