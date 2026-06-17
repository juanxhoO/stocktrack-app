import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/warehouse.dart';
import '../../warehouse_providers.dart';

class WarehouseState {
  final bool isLoading;
  final Warehouse? warehouse;
  final List<Warehouse>? warehouses;
  final String? error;

  const WarehouseState({
    this.isLoading = false,
    this.warehouse,
    this.warehouses,
    this.error,
  });

  WarehouseState copyWith({
    bool? isLoading,
    Warehouse? warehouse,
    List<Warehouse>? warehouses,
    String? error,
  }) {
    return WarehouseState(
      isLoading: isLoading ?? this.isLoading,
      warehouse: warehouse ?? this.warehouse,
      warehouses: warehouses ?? this.warehouses,
      error: error,
    );
  }
}

final warehouseControllerProvider =
    NotifierProvider<WarehouseController, WarehouseState>(
      WarehouseController.new,
    );

class WarehouseController extends Notifier<WarehouseState> {
  @override
  WarehouseState build() {
    return const WarehouseState();
  }

  Future<void> searchWarehouses({String? query}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchWarehousesUseCase = ref.read(searchWarehousesUseCaseProvider);
      final warehousesList = await searchWarehousesUseCase.call(query: query);
      state = state.copyWith(isLoading: false, warehouses: warehousesList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadWarehouse(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final getWarehouseUseCase = ref.read(getWarehouseUseCaseProvider);
      final warehouse = await getWarehouseUseCase.call(id);
      state = state.copyWith(isLoading: false, warehouse: warehouse);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> removeWarehouse(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final deleteWarehouseUseCase = ref.read(deleteWarehouseUseCaseProvider);
      await deleteWarehouseUseCase.call(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createWarehouse({
    String? name,
    String? description,
    String? address,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createWarehouseUseCase = ref.read(createWarehouseUseCaseProvider);
      final warehouse = await createWarehouseUseCase.call(
        name: name,
        description: description,
      );
      state = state.copyWith(isLoading: false, warehouse: warehouse);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateWarehouse({
    String? name,
    String? description,
    String? address,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateWarehouseUseCase = ref.read(updateWarehouseUseCaseProvider);
      final updatedWarehouse = await updateWarehouseUseCase.call(
        name: name,
        description: description,
      );
      state = state.copyWith(isLoading: false, warehouse: updatedWarehouse);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
