import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';
import '../../../../shared/providers/dependencies.dart';

class ProductState {
  final bool isLoading;
  final Product? product;
  final List<Product>? products;
  final String? error;

  const ProductState({
    this.isLoading = false,
    this.product,
    this.products,
    this.error,
  }); 

  ProductState copyWith({
    bool? isLoading,
    Product? product,
    List<Product>? products,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      products: products ?? this.products,
      error: error,
    );
  }
}

final productControllerProvider =
    NotifierProvider<ProductController, ProductState>(
  ProductController.new,
);

class ProductController extends Notifier<ProductState> {
  @override
  ProductState build() {
    return const ProductState();
  }

 Future<void> searchProducts({String? query}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchProductsUseCase = ref.read(searchProductsUseCaseProvider);
      final productsList = await searchProductsUseCase.call(query: query);
      state = state.copyWith(isLoading: false, products: productsList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }


   Future<void> loadProduct(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final getProductUseCase = ref.read(getProductUseCaseProvider);
      final product = await getProductUseCase.call(id);
      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }


   Future<void> removeProduct(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final removeProductUseCase = ref.read(removeProductUseCaseProvider);
      await removeProductUseCase.call(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

   Future<void> createProduct({ 
    String? name,
    String? description,
    String? imageUrl,
    String? unitOfMeasurement,
    int? quantityPerUnit,
    double? pricePerUnit,
   }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final createProductUseCase = ref.read(createProductUseCaseProvider);
      final product = await createProductUseCase.call(
        name: name,
        description: description,
        imageUrl: imageUrl,
        unitOfMeasurement: unitOfMeasurement,
        quantityPerUnit: quantityPerUnit,
        pricePerUnit: pricePerUnit,
      );
      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateProduct({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? unitOfMeasurement,
    int? quantityPerUnit,
    double? pricePerUnit,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateProductUseCase = ref.read(updateProductUseCaseProvider);
      final updatedProduct = await updateProductUseCase.call(
        name: name,
        description: description,
        imageUrl: imageUrl,
        unitOfMeasurement: unitOfMeasurement,
        quantityPerUnit: quantityPerUnit,
        pricePerUnit: pricePerUnit,
      );
      state = state.copyWith(isLoading: false, product: updatedProduct);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
