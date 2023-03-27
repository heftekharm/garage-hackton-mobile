import 'package:dio/dio.dart';
import 'package:garage/common/base_service.dart';

enum LoginResponseStatus { success, notExists, error }

enum VerifyResponseStatus { success, error }

class AuthRepository {
  final baseService = BaseService();

  Future<LoginResponseStatus> login(String phoneNumber) async {
    var response = await baseService.dio.post("auth/request", data: {"phone": phoneNumber});

    if (response.isOk) {
      return LoginResponseStatus.success;
    }

    if (response.isAuthError) {
      return LoginResponseStatus.notExists;
    }

    return LoginResponseStatus.error;
  }

  Future<VerifyResponseStatus> verify(String phoneNumber, String code) async {
    var response = await baseService.dio.post("auth/verify", data: {"phone": phoneNumber, "code": code});
    if (response.isOk) {
      try {
        String token = response.data["data"]?["token"] as String;
        baseService.setToken(token);
      } catch (e) {
        return VerifyResponseStatus.error;
      }
    }

    return VerifyResponseStatus.error;
  }
}

extension on Response {
  bool get isOk {
    return statusCode == 200 || statusCode == 201;
  }

  bool get isAuthError {
    return statusCode == 401 || statusCode == 403;
  }
}
