import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.refreshToken,
    required super.token,
    required super.tokenExpires,
    required super.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      refreshToken: json['refreshToken'] as String,
      token: json['token'] as String,
      tokenExpires: json['tokenExpires'] as int,
      user: json['user'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'token': token,
      'tokenExpires': tokenExpires,
      'user': user,
    };
  }
}
