import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:maya/models/settings/settings.dart';

class LoginService {
  late Box<Settings> _settings;

  Future<bool> isCompleteSettings() async {
    Hive.registerAdapter(SettingsAdapter());

    _settings = await Hive.openBox<Settings>('settings');

    final isCompleteSettings = _settings.get('isCompleteSettings');

    // ignore: unrelated_type_equality_checks
    if (isCompleteSettings != null) {
      return true;
    }
  
    return false;
  }
}