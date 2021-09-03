part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginInitialEvent extends LoginEvent {
  LoginInitialEvent();
}

class SignInButtonPressed extends LoginEvent {
  final String email, password;
  SignInButtonPressed({required this.email, required this.password});
}