import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/services/login.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _loginService;

  LoginBloc(this._loginService):super(LoginInitial()) {
    on<CheckCompleteEvent>((event, emit) async {
      final isCompleteSettings = await _loginService.isCompleteSettings();
      
      if (!isCompleteSettings) {
        emit(NotCompleteSettingsState());
      }
    });
  }
}