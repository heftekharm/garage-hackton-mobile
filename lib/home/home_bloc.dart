import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/home/widgets/reserve_item.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(UserState("", ""))) {}

  reserve(String date, int cost) {}

  exit() {}
}

//states

class UserState {
  final String name;
  final String debt;

  const UserState(this.name, this.debt);

  static UserState fromApiResponse(Map<String, dynamic> response) {
    return UserState(response["name"] as String, response["debt"] as String);
  }
}

class DayState {
  final String weekDay;
  final String date;
  final ReserverStatus reserverStatus;
  final int cost;

  DayState(
    this.weekDay,
    this.date,
    this.reserverStatus,
    this.cost,
  );

  static DayState fromApiResponse(Map<String, dynamic> response) {
    String weekDay = response["dayLabel"] as String;
    String date = response["date"] as String;
    int cost = response["price"] as int;
    ReserverStatus reserverStatus = ReserverStatus.values[response["status"] as int];
    return DayState(weekDay, date, reserverStatus, cost);
  }
}

class HomeState {
  final UserState userState;
  final List<DayState> currentWeekState;
  final List<DayState> nextWeekState;

  const HomeState(this.userState, {this.currentWeekState = const [], this.nextWeekState = const []});

  static HomeState fromApiResponse(Map<String, dynamic> response) {
    var rawCurrent = response["current"] as List<Map<String, dynamic>>;
    var rawNext = response["next"] as List<Map<String, dynamic>>;

    var current = rawCurrent.map((e) => DayState.fromApiResponse(e)).toList();
    var next = rawNext.map((e) => DayState.fromApiResponse(e)).toList();
    var user = UserState.fromApiResponse(response["user"] as Map<String, dynamic>);

    return HomeState(user, currentWeekState: current, nextWeekState: next);
  }
}
