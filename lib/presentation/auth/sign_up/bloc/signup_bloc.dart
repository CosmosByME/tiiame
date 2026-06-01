import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiiame/data/use_case/auth_use_case.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }


  void _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      if (event.password != event.confirmPassword) {
        throw Exception("Parollar mos kelmadi");
      }
      final authUseCase = AuthUseCase();  
      await authUseCase.signUp(event.email, event.password);
      emit(state.copyWith(isLoading: false, isSuccess: true));
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isSuccess: false));    
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }}
