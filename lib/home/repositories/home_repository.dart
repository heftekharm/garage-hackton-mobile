import 'package:garage/common/base_service.dart';
import 'package:garage/common/user_repository.dart';
import 'package:garage/home/home_bloc.dart';

class HomeRepository {
  final baseService = BaseService();
  final userRepository = UserRepository();

  Future<HomeState> getInfo() async {
    var response = await baseService.dio.get("/info");
    var homeState = HomeState.fromApiResponse(response.data);
    return homeState;
  }

  Future<ReserveStatus> reserve(String date, int price) async {
    var response = await baseService.dio.post("/reserve", data: {"date": date, "price": price});
    var message = response.data["message"] as String?;
    var isReserved = response.data["result"] as bool;
    return ReserveStatus(message, isReserved);
  }
}

class ReserveStatus {
  final String? message;
  final bool isReserved;
  ReserveStatus(this.message, this.isReserved);
}
