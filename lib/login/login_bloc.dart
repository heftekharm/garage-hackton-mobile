import 'package:bloc/bloc.dart';

enum SubmitStatus { notReady, ready, progress }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginPhonenumberChanged>(_onLoginPhoneNumberChanged);
    on<LoginPhonenumberSubmited>(_onLoginPhoneNumberSubmitted);
  }

  String _phoneNumber = "";

  _onLoginPhoneNumberChanged(LoginPhonenumberChanged event, Emitter<LoginState> emit) {
    if (event.phoneNumber.length == 8) {
      _phoneNumber = event.phoneNumber;
      emit(state.copyWith(submitStatus: SubmitStatus.ready));
    } else {
      emit(state.copyWith(submitStatus: SubmitStatus.notReady));
    }
  }

  _onLoginPhoneNumberSubmitted(LoginPhonenumberSubmited event, Emitter<LoginState> emit) {
    if (_phoneNumber.startsWith("1")) {
      emit(state.copyWith(errorMessage: "شماره اشتباهه"));
    } else {
      emit(state.copyWith(errorMessage: null));
    }
  }
}

//states
class LoginState {
  SubmitStatus submitStatus;
  String? errorMessage;
  bool isLogined;

  LoginState({this.submitStatus = SubmitStatus.notReady, this.isLogined = false, this.errorMessage});

  LoginState copyWith({
    SubmitStatus? submitStatus,
    String? errorMessage,
  }) {
    return LoginState(
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
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
