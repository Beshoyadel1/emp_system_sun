import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:emp_system_sun/core/services/auth_session.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';

class StoredAuthSession {
  const StoredAuthSession(this.user, this.password);
  final CreateUserRequest user;
  final String password;
}

class AuthLocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String sessionKey = 'auth_session_v1';
  static const String userKey = 'user_data';
  static const String passwordKey = 'password';
  static const String fcmTokenKey = 'fcm_token';
  static Future<void> _operations = Future.value();

  static Future<T> _serialize<T>(Future<T> Function() action) {
    final next = _operations.then((_) => action());
    _operations =
        next.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return next;
  }

  static Future<StoredAuthSession?> _readSession() async {
    final data = await _storage.read(key: sessionKey);
    if (data != null) {
      // The null marker prevents legacy credentials being restored if the
      // browser closes midway through logout or migration.
      final decoded = jsonDecode(data);
      if (decoded == null) return null;
      return StoredAuthSession(
        CreateUserRequest.fromJson(Map<String, dynamic>.from(decoded['user'])),
        decoded['password'] as String,
      );
    }
    final user = await _storage.read(key: userKey);
    final password = await _storage.read(key: passwordKey);
    if (user == null || user.isEmpty || password == null) return null;
    return StoredAuthSession(
        CreateUserRequest.fromJson(jsonDecode(user)), password);
  }

  static Future<StoredAuthSession?> getSession() => _serialize(_readSession);
  static Future<CreateUserRequest?> getUser() async =>
      (await getSession())?.user;
  static Future<String?> getPassword() async => (await getSession())?.password;
  static Future<bool> isLoggedIn() async => await getSession() != null;

  static Future<void> _writeSession(StoredAuthSession session) =>
      _storage.write(
        key: sessionKey,
        value: jsonEncode(
            {'user': session.user.toJson(), 'password': session.password}),
      );

  /// The only credential commit used by manual and automatic login.
  static Future<bool> saveSession({
    required CreateUserRequest user,
    required String password,
    required int version,
  }) =>
      _serialize(() async {
        if (!AuthSession.isCurrent(version)) return false;
        await _writeSession(StoredAuthSession(user, password));
        await _storage.delete(key: userKey);
        await _storage.delete(key: passwordKey);
        return AuthSession.isCurrent(version);
      });

  static Future<bool> updateSession({
    required int version,
    required int? userId,
    CreateUserRequest? user,
    String? password,
    String? email,
  }) =>
      _serialize(() async {
        if (!AuthSession.isCurrent(version)) return false;
        final saved = await _readSession();
        if (!AuthSession.isCurrent(version) ||
            saved == null ||
            saved.user.userid != userId ||
            (email != null && saved.user.email?.trim() != email.trim())) {
          return false;
        }
        await _writeSession(
            StoredAuthSession(user ?? saved.user, password ?? saved.password));
        return AuthSession.isCurrent(version);
      });

  static Future<void> clearSession() => _serialize(() async {
        await _storage.write(key: sessionKey, value: 'null');
        await _storage.delete(key: userKey);
        await _storage.delete(key: passwordKey);
        await _storage.delete(key: fcmTokenKey);
      });

  static Future<void> saveFcmToken(String token, {required int version}) =>
      _serialize(() async {
        if (!AuthSession.isCurrent(version)) return;
        await _storage.write(key: fcmTokenKey, value: token);
      });

  static Future<String?> getFcmToken() =>
      _serialize(() => _storage.read(key: fcmTokenKey));
}
