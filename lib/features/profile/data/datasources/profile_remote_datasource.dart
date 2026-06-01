import 'package:dio/dio.dart';
import '../models/profile_model.dart';

class ProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasource(this.dio);

  Future<ProfileModel> getProfile() async {
    // In a real app:
    // final response = await dio.get('/profile');
    // return ProfileModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return const ProfileModel(
      id: '123',
      email: 'user@example.com',
      name: 'Juan',
      phone: '+1234567890',
    );
  }

  Future<ProfileModel> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
  }) async {
    // In a real app:
    // final response = await dio.put('/profile', data: {
    //   if (name != null) 'name': name,
    //   if (phone != null) 'phone': phone,
    //   if (avatarUrl != null) 'avatarUrl': avatarUrl,
    // });
    // return ProfileModel.fromJson(response.data);

    // Mocked for demonstration
    await Future.delayed(const Duration(seconds: 1));
    return ProfileModel(
      id: '123',
      email: 'user@example.com',
      name: name ?? 'Juan',
      phone: phone ?? '+1234567890',
      avatarUrl: avatarUrl,
    );
  }
}
