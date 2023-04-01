import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = "access_token";

class UserRepository {
  static UserRepository? _instance;

  SharedPreferences? _prefs;

  factory UserRepository() {
    _instance = _instance ?? UserRepository._();
    return _instance!;
  }

  UserRepository._() {
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
    });
  }

  setToken(String token) {
    _prefs?.setString(_tokenKey, token);
  }

  removeToken() {
    _prefs?.remove(_tokenKey);
  }

  String? getToken() => _prefs?.getString(_tokenKey);

  bool get isLogined => getToken() != null;
}
