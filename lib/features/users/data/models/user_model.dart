import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.photo,
    super.password,
    super.phone,
    required super.socialId,
    required super.role,
    required super.status,
    required super.provider,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      socialId: json['socialId'] as String,
      photo: json['photo'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
      provider: json['provider'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'photo': photo,
      'socialId': socialId,
      'role': role,
      'status': status,
      'provider': provider,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
