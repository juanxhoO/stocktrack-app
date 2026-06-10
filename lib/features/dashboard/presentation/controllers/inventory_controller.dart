import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/inventory.dart';
import '../../../../shared/providers/dependencies.dart';

class InventoryState {
  final bool isLoading;
  final Inventory? inventory;
  final List<Inventory>? inventories;
  final String? error;

  const InventoryState({
    this.isLoading = false,
    this.inventory,
    this.inventories,
    this.error,
  });

  InventoryState copyWith({
    bool? isLoading,
    Inventory? inventory,
    List<Inventory>? inventories,
    String? error,
  }) {
    return InventoryState(
      isLoading: isLoading ?? this.isLoading,
      inventory: inventory ?? this.inventory,
      inventories: inventories ?? this.inventories,
      error: error,
    );
  }
}

final inventoryControllerProvider =
    NotifierProvider<InventoryController, InventoryState>(
      InventoryController.new,
    );

class InventoryController extends Notifier<InventoryState> {
  @override
  InventoryState build() {
    return const InventoryState();
  }

  Future<void> searchInventories({String? query}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchInventoriesUseCase = ref.read(
        searchInventoriesUseCaseProvider,
      );
      final inventoriesList = await searchInventoriesUseCase.call(query: query);
      state = state.copyWith(isLoading: false, inventories: inventoriesList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createInventory({
    String? name,
    String? description,
    String? unitOfMeasurement,
    double? price,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createInventoryUseCase = ref.read(createInventoryUseCaseProvider);
      final inventory = await createInventoryUseCase.call(
        name: name,
        description: description,
        unitOfMeasurement: unitOfMeasurement,
        price: price,
      );
      state = state.copyWith(isLoading: false, inventory: inventory);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateInventory({
    String? id,
    String? name,
    String? description,
    String? unitOfMeasurement,
    double? price,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateInventoryUseCase = ref.read(updateInventoryUseCaseProvider);
      final updatedInventory = await updateInventoryUseCase.call(
        name: name,
        description: description,
        unitOfMeasurement: unitOfMeasurement,
        price: price,
      );
      state = state.copyWith(isLoading: false, inventory: updatedInventory);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
