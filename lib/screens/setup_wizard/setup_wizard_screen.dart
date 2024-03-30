import 'package:flutter/material.dart';

class SetupWizardScreen extends StatelessWidget {
  const SetupWizardScreen({super.key});

  static const String routeName = '/wizard';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SetupWizardScreen(),
      settings: const RouteSettings(name: routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('setup wizard'),
    );
  }
}