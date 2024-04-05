part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class CheckCompleteEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends LoginEvent {
  const SignInEvent(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}