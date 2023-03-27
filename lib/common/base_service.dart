import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tokenKey = "access_token";

class BaseService {
  SharedPreferences? _prefs;

  final dio = Dio();

  BaseService() {
    dio.options.baseUrl = "garage.oddrun.ir";
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

  setToken(String token) {
    _prefs?.setString(_tokenKey, token);
  }
}
