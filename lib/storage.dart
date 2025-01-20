abstract class GOSecureStorage {
  String? findAccessToken();

  void saveAccessToken(String? token);

  Future<String?> findRefreshToken();

  Future<void> saveRefreshToken(String? token);

  Future<String?> read(String key);

  Future<void> write(String key, String value);
}
