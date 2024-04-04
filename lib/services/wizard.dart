import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:maya/models/settings/settings.dart';
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
    final output = File('storage');
    final initData = await PGP.OpenPGP.encrypt("Hello", keyPair.publicKey);
    final initDataFileName = await PGP.OpenPGP.encrypt("Hello", keyPair.publicKey);

    final tarEntries = Stream<TarEntry>.value(
      TarEntry.data(
        TarHeader(
          name: initDataFileName,
          mode: int.parse('644', radix: 8),
        ),
        utf8.encode(initData),
      ),
    );

    final gzipData = tarEntries.transform(tarWriter).transform(gzip.encoder);
    final bytesData = await gzipData.reduce((previous, element) => [...previous, ...element]);
  
    final dataString = base64Encode(bytesData);

    final data = utf8.encode(dataString);
    final buffer = data.buffer;
    
    await output.writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
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
