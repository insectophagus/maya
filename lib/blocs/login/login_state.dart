part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class NotCompleteSettingsState extends LoginState {
  @override
  List<Object> get props => [true];
}

class RemovedAllDataState extends LoginState {
  @override
  List<Object> get props => [];
}

class SuccessLoginState extends LoginState {
  @override
  List<Object> get props => [];
}
