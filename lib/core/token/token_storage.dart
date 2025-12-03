// core/token_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _key = 'auth_token';
  static const _userKey = 'user_id';
  final _storage = const FlutterSecureStorage();

  Future<void> save(String token) => _storage.write(key: _key, value: token);
  Future<String?> read() => _storage.read(key: _key);

  Future<void> saveUserId(String userId) =>
      _storage.write(key: _userKey, value: userId);
  Future<String?> readUserId() => _storage.read(key: _userKey);

  Future<void> clear() async {
    await _storage.delete(key: _key);
    await _storage.delete(key: _userKey);
  }
}
