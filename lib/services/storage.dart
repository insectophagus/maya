import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/utils/encrypt_file.dart';
import 'package:openpgp/openpgp.dart';
import 'package:path/path.dart';
import 'package:tar/tar.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  late Box<Settings> settings;

  Future<List<Entry>> openStorage() async {
    final storageData = await EncryptFile.decryptFile('storage.tar.gz.aes');
    final inputStream = Stream.value(List<int>.from(storageData));
    final decodedStream = inputStream.transform(gzip.decoder);
    final List<Entry> entries = [];

    await TarReader.forEach(decodedStream, (entry) async {
      final content = await entry.contents.transform(utf8.decoder).first;

      entries.add(Entry(name: entry.header.name, content: content, id: const Uuid().v4() ));
    });

    return entries;
  }

  Future<Entry> openFile(String filePath) async {
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final publicKey = settingsBox.get('publicKey');
    File file = File(filePath);
    final fileName = basename(filePath);
    final content = await file.readAsString();
    final encryptedContent = await OpenPGP.encrypt('$content\n', publicKey as String);
  
    final entry = Entry(name: fileName, content: encryptedContent, id: const Uuid().v4());

    return entry;
  }

  Future<List<Entry>> updateStorage(Iterable<Entry> newStorageData, bool needEncryptContent) async {
    final output = File('storage.tar.gz');
    final entries = getEntries(newStorageData, needEncryptContent);

    await entries.transform(tarWriter).transform(gzip.encoder).pipe(output.openWrite());

    await EncryptFile.encryptFile('storage.tar.gz');

    await File('storage.tar.gz').delete();

    return await openStorage();
  }

  Stream<TarEntry> getEntries(Iterable<Entry> updatedStorage, bool needEncryptContent) async* {
    final streamStorage = Stream.fromIterable(updatedStorage);
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final publicKey = settingsBox.get('publicKey');
  
    await for (final entry in streamStorage) {
      final content = entry.content;
      final encryptedContent = needEncryptContent ? await OpenPGP.encrypt('$content\n', publicKey as String) : '$content\n';
  
      yield TarEntry.data(
        TarHeader(name: entry.name, mode: int.parse('644', radix: 8)),
        utf8.encode(encryptedContent)
      );
    }
  }
}