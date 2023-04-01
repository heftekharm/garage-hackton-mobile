import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = "access_token";

class BaseService {
  static BaseService? _baseService;

  SharedPreferences? _prefs;

  final dio = Dio();

  BaseService._() {
    dio.options.baseUrl = "https://garage.oddrun.ir/api/";
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
    });

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        var accessToken = _prefs?.getString(_tokenKey);
        if (accessToken != null) {
          options.headers["Authorization"] = "Bearer $accessToken";
        }

        handler.next(options);
      },
    ));
  }

  factory BaseService() {
    _baseService = _baseService ?? BaseService._();
    return _baseService!;
  }

  setToken(String token) {
    _prefs?.setString(_tokenKey, token);
  }

  removeToken() {
    _prefs?.remove(_tokenKey);
  }

  bool get isTokenExisted => _prefs?.getString(_tokenKey) != null;
}
