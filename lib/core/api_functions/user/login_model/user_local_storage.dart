import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api_functions/user/create_user_model/create_user_request.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../user/create_user_model/create_user_request.dart';

class AuthLocalStorage {
  static const String userKey = "user_data";

  /// ✅ Save user
  static Future<void> saveUser(CreateUserRequest user) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(user.toJson());

    await prefs.setString(userKey, jsonString);
  }

  /// ✅ Get user
  static Future<CreateUserRequest?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(userKey);

    if (data == null) return null;

    final jsonMap = jsonDecode(data);

    return CreateUserRequest.fromJson(jsonMap);
  }

  /// ✅ Clear
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}