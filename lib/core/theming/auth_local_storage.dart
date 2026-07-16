import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../../../features/auth_page/data/model/create_user_model/create_user_request.dart';

class AuthLocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String userKey = "user_data";
  static const String passwordKey = "password";

  static Future<void> saveUser(CreateUserRequest user) async {
    await _storage.write(
      key: userKey,
      value: jsonEncode(user.toJson()),
    );
  }

  static Future<CreateUserRequest?> getUser() async {
    final data = await _storage.read(key: userKey);

    if (data == null || data.isEmpty) return null;

    return CreateUserRequest.fromJson(jsonDecode(data));
  }

  static Future<bool> isLoggedIn() async {
    final data = await _storage.read(key: userKey);
    return data != null && data.isNotEmpty;
  }

  static Future<void> clearUser() async {
    await _storage.delete(key: userKey);
  }

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