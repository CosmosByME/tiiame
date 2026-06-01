import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tiiame/data/use_case/auth_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      await AuthUseCase().signIn(event.email, event.password);
      emit(state.copyWith(isLoading: false, isSuccess: true));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isSuccess: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isSuccess: false));
    }
  }
}
