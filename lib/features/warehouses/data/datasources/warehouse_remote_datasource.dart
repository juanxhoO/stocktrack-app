import 'package:dio/dio.dart';
import '../models/warehouse_model.dart';
import '../../../../core/network/api_endpoints.dart';

class WarehouseRemoteDatasource {
  final Dio dio;

  WarehouseRemoteDatasource(this.dio);

  Future<List<WarehouseModel>> searchWarehouses({String? query}) async {
    try {
      final response = await dio.get(
        ApiEndpoints.warehouses,
        queryParameters: {'name': query},
      );
      return List<WarehouseModel>.from(
        response.data['data'].map((x) => WarehouseModel.fromJson(x)),
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

  Future<WarehouseModel> getWarehouse(String id) async {
    final response = await dio.get('${ApiEndpoints.warehouses}/$id');
    return WarehouseModel.fromJson(response.data);
  }

  Future<WarehouseModel> createWarehouse({
    required String name,
    String? code,
    String? phone,
    String? address,
    int? capacity,
    bool? hasClimateControl,
    bool? isActive,
    String? city,
    String? state,
    String? country,
    String? zipCode,
  }) async {
    final response = await dio.post(
      ApiEndpoints.warehouses,
      data: {
        'name': name,
        'code': code,
        'phone': phone,
        'address': address,
        'capacity': capacity,
        'hasClimateControl': hasClimateControl,
        'isActive': isActive,
        'city': city,
        'state': state,
        'country': country,
        'zipcode': zipCode,
      },
    );
    return WarehouseModel.fromJson(response.data);
  }

  Future<WarehouseModel> updateWarehouse({
    required String id,
    required String name,
    String? code,
    String? phone,
    String? address,
    int? capacity,
    bool? hasClimateControl,
    bool? isActive,
    String? city,
    String? state,
    String? country,
    String? zipCode,
  }) async {
    // TODO: Replace with real API call:
    // final response = await dio.put('${ApiEndpoints.warehouses}/$id', data: { ... });
    // return WarehouseModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return WarehouseModel(
      id: int.tryParse(id) ?? 0,
      name: name,
      address: address ?? '',
      hasClimateControl: hasClimateControl ?? false,
      capacity: capacity ?? 0,
      city: city ?? '',
      manager: {"id": 7, "role": null, "status": null},
      isActive: isActive ?? true,
      state: state ?? '',
      country: country ?? '',
      zipcode: zipCode ?? '',
      phone: phone ?? '',
      createdAt: null,
      updatedAt: DateTime.now().toIso8601String(),
      deletedAt: null,
    );
  }

  Future<void> deleteWarehouse(String id) async {
    // TODO: Replace with real API call:
    // await dio.delete('${ApiEndpoints.warehouses}/$id');
    await Future.delayed(const Duration(seconds: 1));
  }
}
