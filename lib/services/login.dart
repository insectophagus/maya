import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:maya/models/settings/settings.dart';

class LoginService {
  late Box<Settings> _settings;

  Future<bool> isCompleteSettings() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');

    if (encryptionKeyString == null) {
      final token = Hive.generateSecureKey();

      await secureStorage.write(key: 'token', value: base64UrlEncode(token));
    }
    Hive.registerAdapter(SettingsAdapter());

    final token = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(token!);

    final _settings = await Hive.openBox<Settings>('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final isCompleteSettings = _settings.get('isCompleteSettings');

    // ignore: unrelated_type_equality_checks
    if (isCompleteSettings != null) {
      return true;
    }
  
    return false;
  }
}