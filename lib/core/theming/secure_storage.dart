import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String passwordKey = "password";

  static Future<void> savePassword(String password) async {
    await _storage.write(
      key: passwordKey,
      value: password,
    );

    final savedPassword = await _storage.read(
      key: passwordKey,
    );

    print("Saved Password: $savedPassword");
  }

  static Future<String?> getPassword() async {
    return await _storage.read(
      key: passwordKey,
    );
  }

  static Future<void> printPassword() async {
    final password = await _storage.read(
      key: passwordKey,
    );

    print("Password: $password");
  }

  static Future<void> clearPassword() async {
    await _storage.delete(
      key: passwordKey,
    );
  }
}