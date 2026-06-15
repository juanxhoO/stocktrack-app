import '../entities/warehouse.dart';
import '../repositories/warehouse_repository.dart';

class SearchWarehousesUseCase {
  final WarehouseRepository repository;

  SearchWarehousesUseCase(this.repository);

  Future<List<Warehouse>> call({String? query}) {
    return repository.searchWarehouses(query: query);
  }
}
