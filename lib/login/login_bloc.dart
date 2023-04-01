import 'package:bloc/bloc.dart';

import 'package:garage/login/repositores/auth_repository.dart';

const phoneNumberLength = 11;

enum SubmitStatus { notReady, ready, progress }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authRepository = AuthRepository();

  LoginBloc() : super(LoginState()) {
    on<LoginPhonenumberChanged>(_onLoginPhoneNumberChanged);
    on<LoginSubmited>(_onLoginSubmitted);
    on<LoginOTPChanged>(_onLoginOTPChanged);
  }

  _onLoginPhoneNumberChanged(LoginPhonenumberChanged event, Emitter<LoginState> emit) {
    var newState = state.copyWithNoErrorMessage().copyWith(currentPhoneNumberValue: event.phoneNumber);
    emit(newState);
  }

  _onLoginSubmitted(LoginSubmited event, Emitter<LoginState> emit) async {
    var newState = state.copyWith(isSubmitting: true);
    emit(newState);
    if (state.shouldVerify) {
      newState = await __onOTPSubmitted(newState);
    } else {
      newState = await __onPhoneNumberSubmitted(newState);
    }
    newState = newState.copyWith(isSubmitting: false);
    emit(newState);
  }

  Future<LoginState> __onPhoneNumberSubmitted(LoginState newState) async {
    var loginStatus = await _authRepository.login(state.currentPhoneNumberValue);
    switch (loginStatus) {
      case LoginResponseStatus.success:
        newState = newState.copyWith(shouldVerify: true);
        break;
      case LoginResponseStatus.notExists:
        newState = newState.copyWith(errorMessage: "شماره اشتباهه");
        break;
      case LoginResponseStatus.error:
        newState = newState.copyWith(errorMessage: "خطا");
        break;
    }
    return newState;
  }

  Future<LoginState> __onOTPSubmitted(LoginState newState) async {
    var loginStatus = await _authRepository.verify(state.currentPhoneNumberValue, state.currentOTPValue);
    switch (loginStatus) {
      case VerifyResponseStatus.success:
        newState = newState.copyWith(isLogined: true);
        break;
      case VerifyResponseStatus.error:
        newState = newState.copyWith(errorMessage: "خطا");
        break;
    }
    return newState;
  }

  _onLoginOTPChanged(LoginOTPChanged event, Emitter<LoginState> emit) {
    var newState = state.copyWithNoErrorMessage().copyWith(currentOTPValue: event.otp);
    emit(newState);
  }
}

//states
class LoginState {
  final String? errorMessage;
  final bool isLogined;
  final String currentPhoneNumberValue;
  final bool isSubmitting;
  final bool shouldVerify;
  final String currentOTPValue;

  LoginState(
      {this.currentPhoneNumberValue = "",
      this.isSubmitting = false,
      this.isLogined = false,
      this.errorMessage,
      this.shouldVerify = false,
      this.currentOTPValue = ""});

  SubmitStatus get submitStatus {
    if (isSubmitting) return SubmitStatus.progress;
    if (currentPhoneNumberValue.length == phoneNumberLength) return SubmitStatus.ready;
    return SubmitStatus.notReady;
  }

  LoginState copyWithNoErrorMessage() {
    return LoginState(
        errorMessage: null,
        isLogined: isLogined,
        currentPhoneNumberValue: currentPhoneNumberValue,
        isSubmitting: isSubmitting,
        shouldVerify: shouldVerify,
        currentOTPValue: currentOTPValue);
  }

  LoginState copyWith({
    String? errorMessage,
    bool? isLogined,
    String? currentPhoneNumberValue,
    bool? isSubmitting,
    bool? shouldVerify,
    String? currentOTPValue,
  }) {
    return LoginState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLogined: isLogined ?? this.isLogined,
      currentPhoneNumberValue: currentPhoneNumberValue ?? this.currentPhoneNumberValue,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      shouldVerify: shouldVerify ?? this.shouldVerify,
      currentOTPValue: currentOTPValue ?? this.currentOTPValue,
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

class LoginOTPChanged extends LoginEvent {
  final String otp;
  const LoginOTPChanged(this.otp);
}

class LoginSubmited extends LoginEvent {
  const LoginSubmited();
}
