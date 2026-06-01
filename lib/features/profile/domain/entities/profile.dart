class Profile {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final String? phone;

  const Profile({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.phone,
  });
}
