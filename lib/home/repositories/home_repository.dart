import 'package:garage/common/base_service.dart';
import 'package:garage/common/user_repository.dart';
import 'package:garage/home/home_bloc.dart';
import 'package:garage/home/widgets/reserve_item.dart';

HomeState _mockedHomeState = HomePageLoadedState(UserModel("حسین", "1000"), currentWeek: [
  DayModel("یکشنبه", "13 فروردین", ReserverStatus.biddableFull, 50),
  DayModel("دوشنبه", "14 فروردین", ReserverStatus.reservable, 50),
  DayModel("یکشنبه", "15 فروردین", ReserverStatus.holiday, 50),
  DayModel("یکشنبه", "16 فروردین", ReserverStatus.notBiddableFull, 50),
  DayModel("یکشنبه", "17 فروردین", ReserverStatus.reserved, 50),
  DayModel("یکشنبه", "18 فروردین", ReserverStatus.passed, 50),
]);

class HomeRepository {
  final _baseService = BaseService();
  final _userRepository = UserRepository();

  Future<HomeState> getInfo() async {
    //var response = await _baseService.dio.get("/info");
    var homeState = _mockedHomeState; //HomePageLoadedState.fromApiResponse(response.data);
    return homeState;
  }

  Future<ReserveRequestResult> reserve(String date, int price) async {
    var response = await _baseService.dio.post("/reserve", data: {"date": date, "price": price});
    var message = response.data["message"] as String?;
    var isReserved = response.data["result"] as bool;

    return ReserveRequestResult(message, isReserved);
  }
}

class ReserveRequestResult {
  final String? message;
  final bool isReserved;
  ReserveRequestResult(this.message, this.isReserved);
}
