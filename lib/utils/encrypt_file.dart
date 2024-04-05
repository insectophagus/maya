import 'dart:typed_data';

import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptFile {
  static Future<void> encryptFile(String path) async {
    final crypt = AesCrypt();
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');

    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword(encryptionKeyString!);
    await crypt.encryptFile(path);
  }

  static Future<Uint8List> decryptFile(String path) async {
    final crypt = AesCrypt();
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');

    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword(encryptionKeyString!);

    final filePath = await crypt.decryptDataFromFile(path);

    return filePath;
  }
}