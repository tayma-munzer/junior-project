import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthManager {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'user_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveRoles(List roles) async {
    //await _storage.write(key: _tokenKey, value: token);
    Map<String, bool> saveRoles = {
      'serviceOwner': false,
      'jobOwner': false,
      'user': false
    };
    for (var role in roles) {
      if (role["role"] == "صاحب خدمة") {
        saveRoles['serviceOwner'] = true;
      } else if (role["role"] == "صاحب فرصة عمل") {
        saveRoles['jobOwner'] = true;
      } else if (role["role"] == "مستفيد") {
        saveRoles['user'] = true;
      } else {
        print("Unknown role");
      }
    }
    print(saveRoles);
    for (var entry in saveRoles.entries) {
      String key = entry.key;
      bool value = entry.value;
      await _storage.write(key: key, value: value.toString());
    }
  }

  static Future<String?> isjobOwner() async {
    return await _storage.read(key: 'jobOwner');
  }

  static Future<String?> isserviceOwner() async {
    return await _storage.read(key: 'serviceOwner');
  }

  static Future<String?> isUser() async {
    return await _storage.read(key: 'user');
  }
}
