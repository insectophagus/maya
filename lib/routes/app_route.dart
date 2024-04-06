import 'package:flutter/material.dart';
import 'package:maya/screens/error/error_screen.dart';
import 'package:maya/screens/home/home_screen.dart';
import 'package:maya/screens/login/login_screen.dart';
import 'package:maya/screens/setup_wizard/setup_wizard_screen.dart';
import 'package:maya/screens/text_editor/text_editor.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case SetupWizardScreen.routeName:
        return SetupWizardScreen.route();

      case TextEditor.routeName:
        return TextEditor.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const ErrorScreen(),
    );
  }
}