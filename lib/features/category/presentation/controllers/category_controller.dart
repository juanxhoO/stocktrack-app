import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category.dart';
import '../../category_providers.dart';

class CategoryState {
  final bool isLoading;
  final Category? category;
  final List<Category>? categories;
  final String? error;

  const CategoryState({
    this.isLoading = false,
    this.category,
    this.categories,
    this.error,
  });

  CategoryState copyWith({
    bool? isLoading,
    Category? category,
    List<Category>? categories,
    String? error,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      category: category ?? this.category,
      categories: categories ?? this.categories,
      error: error,
    );
  }
}

final categoryControllerProvider =
    NotifierProvider<CategoryController, CategoryState>(CategoryController.new);

class CategoryController extends Notifier<CategoryState> {
  @override
  CategoryState build() {
    return const CategoryState();
  }

  Future<void> searchCategories({String? query}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final searchCategoriesUseCase = ref.read(searchCategoriesUseCaseProvider);
      final categoriesList = await searchCategoriesUseCase.call(query: query);
      state = state.copyWith(isLoading: false, categories: categoriesList);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadCategory(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final getCategoryUseCase = ref.read(getCategoryUseCaseProvider);
      final category = await getCategoryUseCase.call(id);
      state = state.copyWith(isLoading: false, category: category);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> removeCategory(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final deleteCategoryUseCase = ref.read(deleteCategoryUseCaseProvider);
      await deleteCategoryUseCase.call(id);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> createCategory({
    String? name,
    String? description,
    bool? status,
    num? parentId,
    required String slug,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final createCategoryUseCase = ref.read(createCategoryUseCaseProvider);
      final category = await createCategoryUseCase.call(
        name: name,
        description: description,
        slug: slug,
        status: status,
        parentId: parentId,
      );
      state = state.copyWith(isLoading: false, category: category);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> updateCategory({
    String? id,
    String? name,
    String? description,
    String? slug,
    bool? status,
    num? parentId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updateCategoryUseCase = ref.read(updateCategoryUseCaseProvider);
      final updatedCategory = await updateCategoryUseCase.call(
        id: id,
        status: status,
        name: name,
        description: description,
        slug: slug,
      );
      state = state.copyWith(isLoading: false, category: updatedCategory);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
}
