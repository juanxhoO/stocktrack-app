import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/supplier.dart';
import '../../supplier_providers.dart';

class SupplierState {
  final bool isLoading;
  final Supplier? supplier;
  final List<Supplier>? suppliers;
  final String? error;

  const SupplierState({
    this.isLoading = false,
    this.supplier,
    this.suppliers,
    this.error,
  });

  SupplierState copyWith({
    bool? isLoading,
    Supplier? supplier,
    List<Supplier>? suppliers,
    String? error,
  }) {
    return SupplierState(
      isLoading: isLoading ?? this.isLoading,
      supplier: supplier ?? this.supplier,
      suppliers: suppliers ?? this.suppliers,
      error: error,
    );
  }
}

final supplierControllerProvider =
    NotifierProvider<SupplierController, SupplierState>(SupplierController.new);

class SupplierController extends Notifier<SupplierState> {
  @override
  SupplierState build() {
    return const SupplierState();
  }

  Future<void> searchSuppliers({String? query}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchSuppliersUseCase = ref.read(searchSuppliersUseCaseProvider);
      final suppliersList = await searchSuppliersUseCase.call(query: query);
      state = state.copyWith(isLoading: false, suppliers: suppliersList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadSupplier(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final getSupplierUseCase = ref.read(getSupplierUseCaseProvider);
      final supplier = await getSupplierUseCase.call(id);
      state = state.copyWith(isLoading: false, supplier: supplier);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> removeSupplier(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final deleteSupplierUseCase = ref.read(deleteSupplierUseCaseProvider);
      await deleteSupplierUseCase.call(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createSupplier({String? name, String? description}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createSupplierUseCase = ref.read(createSupplierUseCaseProvider);
      final supplier = await createSupplierUseCase.call(
        name: name,
        description: description,
      );
      state = state.copyWith(isLoading: false, supplier: supplier);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateSupplier({String? name, String? description}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateSupplierUseCase = ref.read(updateSupplierUseCaseProvider);
      final updatedSupplier = await updateSupplierUseCase.call(
        name: name,
        description: description,
      );
      state = state.copyWith(isLoading: false, supplier: updatedSupplier);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
