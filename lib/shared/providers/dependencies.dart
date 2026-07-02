import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/token_storage.dart';

// --- Core Providers ---

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // Initialized in main.dart
});

final dioClientProvider = Provider<DioClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return DioClient(tokenStorage);
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TokenStorage(prefs);
});
