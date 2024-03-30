import 'package:flutter/material.dart';
import 'package:maya/screens/setup_wizard/widgets/step_one.dart';

class SetupWizardScreen extends StatelessWidget {
  final passwordField = TextEditingController();
  final resetPasswordField = TextEditingController();

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
    return  Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 300,
          child: StepOne(passwordField: passwordField, resetPasswordField: resetPasswordField),
        ),
      ),
    );
  }
}