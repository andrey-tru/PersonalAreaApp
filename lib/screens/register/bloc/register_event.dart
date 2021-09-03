part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends RegisterEvent {
  final String email, password, confirmationPassword;
  final dynamic data;
  SignUpButtonPressed(
      {required this.email,
      required this.password,
      required this.confirmationPassword,
      required this.data});
}
