import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = "access_token";
const _phoneNumberKey = "phone_number";

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

  setUser(String phoneNumber, String token) {
    _prefs?.setString(_phoneNumberKey, phoneNumber);
    _prefs?.setString(_tokenKey, token);
  }

  removeUser() {
    _prefs?.remove(_tokenKey);
    _prefs?.remove(_phoneNumberKey);
  }

  String? getToken() => _prefs?.getString(_tokenKey);
  String? getPhoneNumber() => _prefs?.getString(_phoneNumberKey);

  bool get isLogined => getToken() != null;
}
