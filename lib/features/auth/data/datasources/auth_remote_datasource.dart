import 'package:dio/dio.dart';
// import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<UserModel> login(String email, String password) async {
    try {
      // In a real app, this would be:
      // final response = await dio.post(ApiEndpoints.login, data: {'email': email, 'password': password});
      // return UserModel.fromJson(response.data);
      
      // Mocked delay for demonstration
      await Future.delayed(const Duration(seconds: 2));
      
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password cannot be empty');
      }
      
      return UserModel(
        id: '123',
        email: email,
      );
    } catch (e) {
      rethrow;
    }
  }
}
