class User {
  final String refreshToken;
  final String token;
  final int tokenExpires;
  final Map<String, dynamic> user;

  const User({
    required this.refreshToken,
    required this.token,
    required this.tokenExpires,
    required this.user,
  });
}
