import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/login/login_bloc.dart';
import 'package:maya/screens/home/home_screen.dart';
import 'package:maya/screens/login/widgets/login_widget.dart';
import 'package:maya/screens/setup_wizard/setup_wizard_screen.dart';
import 'package:maya/services/login.dart';

class LoginScreen extends StatelessWidget {
  final passwordField = TextEditingController();

  LoginScreen({super.key});
  

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
      settings: const RouteSettings(name: routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          RepositoryProvider.of<LoginService>(context)
        )..add(CheckCompleteEvent()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is NotCompleteSettingsState || state is RemovedAllDataState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SetupWizardScreen(),
                  )
                );
              }

              if (state is SuccessLoginState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  )
                );
              }
            },
            builder: (context, state) {
              return Login(passwordField: passwordField);
            },
          ),
        ),
      ),
    );
  }
}