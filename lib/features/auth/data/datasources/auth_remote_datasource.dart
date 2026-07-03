import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      // Handle specific API errors, e.g., 401 Unauthorized
      if (e.response?.statusCode == 401) {
        throw Exception('Invalid email or password');
      }
      if (e.response?.statusCode == 422) {
        throw Exception(e.response?.data['errors'].toString());
      }
      throw Exception(e.response?.data['errors'].toString());
    }
  }
}
