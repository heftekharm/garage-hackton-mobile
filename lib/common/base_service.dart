import 'package:dio/dio.dart';
import 'package:garage/common/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseService {
  static BaseService? _baseService;

  UserRepository userRepository = UserRepository();

  final dio = Dio();

  BaseService._() {
    dio.options.baseUrl = "https://garage.oddrun.ir/api/";
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        var accessToken = userRepository.getToken();
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
}
