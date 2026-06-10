import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';

class SearchInventoriesUseCase {
  final InventoryRepository inventoryRepository;

  SearchInventoriesUseCase(this.inventoryRepository);

  Future<List<Inventory>> call({String? query}) {
    return inventoryRepository.searchInventories(query: query);
  }
}
