class ApiEndpoints {
  static const String baseUrl = 'http://localhost:3000/api/v1';
  static const String login = '$baseUrl/auth/email/login';
  static const String register = '$baseUrl/auth/email/register';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String warehouses = '$baseUrl/warehouses';
  static const String categories = '$baseUrl/categories';
}
