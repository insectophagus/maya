import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/services/login.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _loginService;

  LoginBloc(this._loginService):super(LoginInitial()) {
    on<CheckCompleteEvent>(checkComplete);
    on<SignInEvent>(signIn);
  }

  Future<void> checkComplete(CheckCompleteEvent event, Emitter<LoginState> emit) async {
    final isCompleteSettings = await _loginService.isCompleteSettings();
    
    if (!isCompleteSettings) {
      emit(NotCompleteSettingsState());
    }
  }

  Future<void> signIn(SignInEvent event, Emitter<LoginState> emit) async {
    final isResetPassword = await _loginService.isResetPassword(event.password);

    if (isResetPassword) {
      await _loginService.removeAllData();

      emit(RemovedAllDataState());
    } else {
      await _loginService.login(event.password);

      emit(SuccessLoginState());
    }
  }
}