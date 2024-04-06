import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/utils/encrypt_file.dart';
import 'package:openpgp/openpgp.dart' as PGP;
import 'package:tar/tar.dart';

class SettingsData {
  late String password;
  late String resetPassword;
  String? passphrase;
  late String tokenName;
  late String email;
}

class WizardService {
  late Box<Settings> settings;

  Future<PGP.KeyPair> saveSettings(SettingsData settings) async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    var keyOptions = PGP.KeyOptions()..rsaBits = 2048;
    var keyPair = await PGP.OpenPGP.generate(
            options: PGP.Options()
              ..name = settings.tokenName
              ..email = settings.email
              ..passphrase = settings.passphrase
              ..keyOptions = keyOptions);

    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final password = settings.password;
    final resetPassword = settings.resetPassword;
    
    await settingsBox.putAll({
      'password': password,
      'resetPassword': resetPassword,
      'publicKey': keyPair.publicKey,
      'privateKey': keyPair.privateKey,
      'passphrase': settings.passphrase
    });

    settingsBox.close();

    return keyPair;
  }

  Future<void> createArchive(PGP.KeyPair keyPair) async {
    final output = File('storage.tar.gz');
    final initData = await PGP.OpenPGP.encrypt("Hello\n\n", keyPair.publicKey);

    final tarEntries = Stream<TarEntry>.value(
      TarEntry.data(
        TarHeader(
          name: 'Hello.txt',
          mode: int.parse('644', radix: 8),
        ),
        utf8.encode(initData),
      ),
    );

    await tarEntries.transform(tarWriter).transform(gzip.encoder).pipe(output.openWrite());

    await EncryptFile.encryptFile('storage.tar.gz');

    await File('storage.tar.gz').delete();
  }

  Future<void> completeSetup() async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

    settingsBox.put('isCompleteSettings', true);
    settingsBox.close();
  }
}
