import 'dart:convert';

import 'package:foyer/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/logs.dart';

class Prefs {
  static late SharedPreferences _preferences;
  static const int _keyVersion = 0;
  static const String usersKey = 'user$_keyVersion';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static _setString(String key, String? value) {
    if (value != null) {
      _preferences.setString(key, value);
    } else {
      _preferences.remove(key);
    }
    logPrefsStore(key, value);
  }

  static Future<bool> setUser(UserModel user) async {
    try {
      final String id = user.getId();
      List<String> users = getUsers() ?? [];
      if (!users.contains(id)) {
        users.add(id);
      }
      await _setString(usersKey, jsonEncode(users));
      await _setString(id, jsonEncode(user));
      return true;
    } catch (e, stacktrace) {
      logError(e, stacktrace);
      return false;
    }
  }

  static List<String>? getUsers() {
    String? usersStr = _preferences.getString(usersKey);
    if (usersStr == null) {
      return null;
    }
    List? users = jsonDecode(usersStr);
    if (users == null || users.isEmpty) {
      return null;
    }
    return users.map((e) => e.toString()).toList();
  }

  static UserModel? getUser(String id) {
    List<String>? users = getUsers();
    if (users == null || users.isEmpty || !users.contains(id)) {
      return null;
    }
    String? userStr = _preferences.getString(id);
    if (userStr == null) {
      throw 'Missing';
    }
    Map<String, dynamic>? userMap = jsonDecode(userStr);
    if (userMap == null) {
      throw 'Missing';
    }
    UserModel? user = UserModel.fromJson(userMap);
    return user;
  }
}
