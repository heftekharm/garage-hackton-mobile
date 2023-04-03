import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/home/repositories/home_repository.dart';
import 'package:garage/home/widgets/reserve_item.dart';

class HomeCubit extends Cubit<HomeState> {
  final _homeRepository = HomeRepository();

  HomeCubit() : super(const HomePageLoadedState(UserModel("", ""))) {
    fetch();
  }

  fetch() async {
    await Future.delayed(Duration(seconds: 1));
    var homeState = await _homeRepository.getInfo();
    emit(homeState);
  }

  reserve(String date, int cost) async {
    var result = await _homeRepository.reserve(date, cost);
  }

  exit() {}
}

//states

class UserModel extends Equatable {
  final String name;
  final String debt;

  const UserModel(this.name, this.debt);

  static UserModel fromApiResponse(Map<String, dynamic> response) {
    return UserModel(response["name"] as String, response["debt"] as String);
  }

  @override
  List<Object?> get props => [name, debt];
}

class DayModel extends Equatable {
  final String weekDay;
  final String date;
  final ReserverStatus reserverStatus;
  final int cost;

  const DayModel(
    this.weekDay,
    this.date,
    this.reserverStatus,
    this.cost,
  );

  static DayModel fromApiResponse(Map<String, dynamic> response) {
    String weekDay = response["dayLabel"] as String;
    String date = response["date"] as String;
    int cost = response["price"] as int;
    ReserverStatus reserverStatus = ReserverStatus.values[response["status"] as int];
    return DayModel(weekDay, date, reserverStatus, cost);
  }

  @override
  List<Object?> get props => [weekDay, date, reserverStatus, cost];
}

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => const [];
}

class SubmittingRequest extends HomeState {}

class HomePageLoadedState extends HomeState {
  final UserModel user;
  final List<DayModel> currentWeek;
  final List<DayModel> nextWeek;

  const HomePageLoadedState(this.user, {this.currentWeek = const [], this.nextWeek = const []});

  static HomePageLoadedState fromApiResponse(Map<String, dynamic> response) {
    var rawCurrent = response["current"] as List<Map<String, dynamic>>;
    var rawNext = response["next"] as List<Map<String, dynamic>>;

    var current = rawCurrent.map((e) => DayModel.fromApiResponse(e)).toList();
    var next = rawNext.map((e) => DayModel.fromApiResponse(e)).toList();
    var user = UserModel.fromApiResponse(response["user"] as Map<String, dynamic>);

    return HomePageLoadedState(user, currentWeek: current, nextWeek: next);
  }

  @override
  List<Object?> get props => [user, ...currentWeek, ...nextWeek];
}
