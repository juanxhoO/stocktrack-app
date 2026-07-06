class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String socialId;
  final String? photo;
  final String? password;
  final String? phone;
  final String? role;
  final String? status;
  final String? provider;
  final String? createdAt;
  final String? updatedAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photo,
    this.password,
    this.phone,
    required this.socialId,
    required this.role,
    required this.status,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
  });
}
