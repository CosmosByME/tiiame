part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final bool isSuccess;
  const SignupState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.isSuccess = false,
  });

  SignupState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isSuccess,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
  
  @override
  List<Object> get props => [email, password, isLoading, isSuccess];
}

final class SignupInitial extends SignupState {}
