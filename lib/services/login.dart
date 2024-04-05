import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:maya/models/settings/settings.dart';

class LoginService {
  late Box<Settings> settings;

  Future<bool> isCompleteSettings() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');

    if (encryptionKeyString == null) {
      final token = Hive.generateSecureKey();

      await secureStorage.write(key: 'token', value: base64UrlEncode(token));
    }

    final token = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(token!);

    final settings = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final isCompleteSettings = settings.get('isCompleteSettings');

    settings.close();
    // ignore: unrelated_type_equality_checks
    if (isCompleteSettings != null) {
      return true;
    }
  
    return false;
  }

  Future<bool> isResetPassword(String password) async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final resetPassword = settingsBox.get('resetPassword') as String;

    return password == resetPassword;
  }

  Future<void> removeAllData() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

    settingsBox.clear();

    File storage = File('storage');

    await storage.delete();
  }

  Future<void> login(String password) async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final savedPassword = settingsBox.get('password') as String;

    if (password != savedPassword) {
      throw Exception('password is incorrect');
    }
  }
}