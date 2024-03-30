import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/login/login_bloc.dart';
import 'package:maya/screens/setup_wizard/setup_wizard_screen.dart';
import 'package:maya/services/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
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
              if (state is NotCompleteSettingsState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SetupWizardScreen(),
                  )
                );
              }
            },
            builder: (context, state) {
              return const Text('login');
            },
          ),
        ),
      ),
    );
  }
}