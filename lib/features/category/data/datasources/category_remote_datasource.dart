import 'package:dio/dio.dart';
import '../models/category_model.dart';
import '../../../../core/network/api_endpoints.dart';

class CategoryRemoteDatasource {
  final Dio dio;
  final images = [
    'https://picsum.photos/seed/product1/600/600',
    'https://picsum.photos/seed/product2/600/600',
    'https://picsum.photos/seed/product3/600/600',
    'https://picsum.photos/seed/product4/600/600',
    'https://picsum.photos/seed/product5/600/600',
  ];
  CategoryRemoteDatasource(this.dio);

  Future<List<CategoryModel>> searchCategories({String? query}) async {
    try {
      final response = await dio.get(
        ApiEndpoints.categories,
        queryParameters: {'name': query},
      );
      return List<CategoryModel>.from(
        response.data['data'].map((x) => CategoryModel.fromJson(x)),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      }
      if (e.response?.statusCode == 422) {
        throw Exception(e.response?.data['errors'].toString());
      }
      throw Exception(e.response?.data['errors'].toString());
    }
  }

  Future<CategoryModel> getCategory(String id) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return const CategoryModel(
      id: 1,
      name: 'Wireless Headphones',
      description: 'Premium noise cancelling headphones.',
      slug: 'wireless-headphones',
      status: true,
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    );
  }

  Future<CategoryModel> createCategory({
    String? name,
    String? description,
    String? slug,
    int? parentId,
  }) async {
    // In a real app:
    // final response = await dio.post('/products', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return CategoryModel(
      id: 124,
      name: name ?? 'New Product',
      description: description ?? 'New Description',
      slug: 'new-product',
      status: true,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<CategoryModel> updateCategory({
    String? id,
    String? name,
    String? description,
    String? slug,
    int? parentId,
  }) async {
    try {
      final response = await dio.patch(
        ApiEndpoints.categories + "/${id}",
        data: {
          'name': name,
          'description': description,
          'slug': slug,
          'parent_id': parentId,
        },
      );
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      }
      if (e.response?.statusCode == 422) {
        throw Exception(e.response?.data['errors'].toString());
      }
      throw Exception(e.response?.data['errors'].toString());
    }
  }

  Future<void> deleteCategory(String id) async {
    // In a real app:
    // await dio.delete('/products/$id');

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
  }
}
