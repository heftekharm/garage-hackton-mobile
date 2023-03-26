import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/home/widgets/reserve_item.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(UserState("", ""))) {}
}

class HomeEvent {}

class ExitHomeEvent extends HomeEvent {}

class ReserveEvent extends HomeEvent {
  final String date;
  final int cost;
  ReserveEvent(this.date, this.cost);
}

//states

class UserState {
  final String name;
  final String debt;

  const UserState(this.name, this.debt);
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
}

class WeekState {
  final List<DayState> days;
  const WeekState(this.days);
}

class HomeState {
  final UserState userState;
  final WeekState currentWeekState;
  final WeekState nextWeekState;

  const HomeState(this.userState, {this.currentWeekState = const WeekState([]), this.nextWeekState = const WeekState([])});
}
