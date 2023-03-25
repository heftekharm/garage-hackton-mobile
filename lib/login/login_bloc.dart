import 'package:bloc/bloc.dart';

const phoneNumberLength = 11;

enum SubmitStatus { notReady, ready, progress }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginPhonenumberChanged>(_onLoginPhoneNumberChanged);
    on<LoginPhonenumberSubmited>(_onLoginPhoneNumberSubmitted);
  }

  _onLoginPhoneNumberChanged(LoginPhonenumberChanged event, Emitter<LoginState> emit) {
    var newState = state.copyWith(currentPhoneNumberValue: event.phoneNumber);
    emit(newState);
  }

  _onLoginPhoneNumberSubmitted(LoginPhonenumberSubmited event, Emitter<LoginState> emit) async {
    var newState = state.copyWith(isSubmitting: true);
    emit(newState);
    await Future.delayed(const Duration(seconds: 1));
    if (state.currentPhoneNumberValue == "09179617587") {
      newState = newState.copyWith(isLogined: true);
    } else {
      newState = newState.copyWith(errorMessage: "شماره اشتباهه");
    }
    newState = state.copyWith(isSubmitting: false);
    emit(newState);
  }
}

//states
class LoginState {
  final String? errorMessage;
  final bool isLogined;
  final String currentPhoneNumberValue;
  final bool isSubmitting;

  LoginState({this.currentPhoneNumberValue = "", this.isSubmitting = false, this.isLogined = false, this.errorMessage});

  SubmitStatus get submitStatus {
    if (isSubmitting) return SubmitStatus.progress;
    if (currentPhoneNumberValue.length == phoneNumberLength) return SubmitStatus.ready;
    return SubmitStatus.notReady;
  }

  LoginState copyWith({bool? isSubmitting, String? errorMessage, String? currentPhoneNumberValue, bool? isLogined}) {
    return LoginState(
        isSubmitting: isSubmitting ?? this.isSubmitting,
        errorMessage: errorMessage ?? this.errorMessage,
        isLogined: isLogined ?? this.isLogined,
        currentPhoneNumberValue: currentPhoneNumberValue ?? this.currentPhoneNumberValue);
  }
}

//events

abstract class LoginEvent {
  const LoginEvent();
}

class LoginPhonenumberChanged extends LoginEvent {
  final String phoneNumber;
  const LoginPhonenumberChanged(this.phoneNumber);
}

class LoginOPTChanged extends LoginEvent {
  final String otp;
  const LoginOPTChanged(this.otp);
}

class LoginPhonenumberSubmited extends LoginEvent {
  const LoginPhonenumberSubmited();
}
