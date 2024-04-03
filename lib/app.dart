import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/routes/app_route.dart';
import 'package:maya/screens/login/login_screen.dart';
import 'package:maya/services/login.dart';
import 'package:maya/services/wizard.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    Hive.registerAdapter(SettingsAdapter());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginService()),
        RepositoryProvider(create: (context) => WizardService())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
