import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gabinandobin_app_toolkit/storage.dart';

class GODefaultSecureStorage implements GOSecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _accessToken;

  @override
  String? findAccessToken() {
    return _accessToken;
  }

  @override
  void saveAccessToken(String? token) {
    _accessToken = token;
  }

  @override
  Future<String?> findRefreshToken() async {
    return await _storage.read(key: "refreshToken");
  }

  @override
  Future<void> saveRefreshToken(String? token) async {
    await _storage.write(key: "refreshToken", value: token);
  }

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }
}
