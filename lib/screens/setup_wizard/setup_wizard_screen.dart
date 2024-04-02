import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/wizard/wizard_bloc.dart';
import 'package:maya/screens/setup_wizard/widgets/step_one.dart';
import 'package:maya/screens/setup_wizard/widgets/step_two.dart';
import 'package:maya/services/wizard.dart';

class SetupWizardScreen extends StatelessWidget {
  final passwordField = TextEditingController();
  final resetPasswordField = TextEditingController();
  final emailField = TextEditingController();
  final passphraseField = TextEditingController();
  final tokenNameField = TextEditingController();

  SetupWizardScreen({super.key});

  static const String routeName = '/wizard';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => SetupWizardScreen(),
      settings: const RouteSettings(name: routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WizardBloc(RepositoryProvider.of<WizardService>(context))),
          BlocProvider(create: (context) => WizardCubit())
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BlocConsumer<WizardBloc, WizardState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              if (state.step == 1) {
                return StepOne(passwordField: passwordField, resetPasswordField: resetPasswordField);
              }

              return StepTwo(passphraseField: passphraseField, tokenNameField: tokenNameField, emailField: emailField);
            },
          ),
        ),
      ),
    );
  }
}