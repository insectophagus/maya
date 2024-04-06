import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:openpgp/openpgp.dart' as PGP;

class DecryptValue {
  static Future<String> decrypt(String value) async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final decryptContent = await PGP.OpenPGP.decrypt(value, settingsBox.get('privateKey'), settingsBox.get('passphrase'));

    return decryptContent;
  }
}