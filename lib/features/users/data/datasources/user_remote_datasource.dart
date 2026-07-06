import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserRemoteDatasource {
  final Dio dio;
  final images = [
    'https://picsum.photos/seed/product1/600/600',
    'https://picsum.photos/seed/product2/600/600',
    'https://picsum.photos/seed/product3/600/600',
    'https://picsum.photos/seed/product4/600/600',
    'https://picsum.photos/seed/product5/600/600',
  ];
  UserRemoteDatasource(this.dio);

  Future<List<UserModel>> searchUsers({String? query}) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return [
      UserModel(
        id: '3',
        firstName: 'Mechanical Keyboard',
        lastName: 'Blue switch mechanical keyboard.',
        email: 'sdsd@gmail.com',
        phone: '1234567890125',
        socialId: '1234567890125',
        role: 'Electronics',
        status: 'Active',
        provider: 'Google',
        photo: images[3],
        createdAt: '2023-10-01T00:00:00.000Z',
        updatedAt: '2023-10-01T00:00:00.000Z',
      ),
      UserModel(
        id: '3',
        firstName: 'Mechanical Keyboard',
        lastName: 'Blue switch mechanical keyboard.',
        email: 'sdsd@gmail.com',
        socialId: '1234567890125',
        role: 'Electronics',
        status: 'Active',
        provider: 'Google',
        photo: images[3],
        createdAt: '2023-10-01T00:00:00.000Z',
        updatedAt: '2023-10-01T00:00:00.000Z',
      ),
      UserModel(
        id: '3',
        firstName: 'Mechanical Keyboard',
        lastName: 'Blue switch mechanical keyboard.',
        email: 'sdsd@gmail.com',
        socialId: '1234567890125',
        role: 'Electronics',
        status: 'Active',
        provider: 'Google',
        photo: images[3],
        createdAt: '2023-10-01T00:00:00.000Z',
        updatedAt: '2023-10-01T00:00:00.000Z',
      ),
    ];
  }

  Future<UserModel> getUser(String id) async {
    // In a real app:
    // final response = await dio.get('/products/$id');
    // return ProductModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: id,
      firstName: 'Wireless Headphones',
      lastName: 'Premium noise cancelling headphones.',
      email: 'sdsd@gmail.com',
      phone: '1234567890125',
      socialId: '1234567890125',
      role: 'Electronics',
      status: 'Active',
      provider: 'Google',
      photo: images[1],
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: '2023-10-01T00:00:00.000Z',
    );
  }

  Future<UserModel> createUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? photo,
    String? status,
    String? socialId,
    String? role,
    String? provider,
  }) async {
    // In a real app:
    // final response = await dio.post('/products', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: '124',
      firstName: firstName ?? 'New User',
      lastName: lastName ?? 'New User',
      email: email ?? 'dsdsd',
      password: password ?? '111111',
      phone: phone ?? '1234567890125',
      photo: photo ?? images[1],
      socialId: socialId ?? '1234567890125',
      role: role ?? 'Owner',
      status: status ?? 'Active',
      provider: provider ?? 'Email',
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<UserModel> updateUser({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? photo,
    String? socialId,
    String? role,
    String? status,
    String? provider,
  }) async {
    // In a real app:
    // final response = await dio.put('/products/$id', data: { ... });
    // return ProductModel.fromJson(response.data);

    await Future.delayed(const Duration(seconds: 1));
    return UserModel(
      id: id ?? '123',
      firstName: firstName ?? 'Updated Product',
      lastName: lastName ?? 'Updated Description',
      email: email ?? 'sdsd@gmail.com',
      socialId: socialId ?? '1234567890125',
      role: role ?? 'General',
      status: status ?? 'Active',
      provider: provider ?? 'Google',
      photo: images[1],
      createdAt: '2023-10-01T00:00:00.000Z',
      updatedAt: DateTime.now().toIso8601String(),
    );
  }

  Future<void> deleteUser(String id) async {
    // In a real app:
    // await dio.delete('/users/$id');

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
  }
}
