import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/utils/encrypt_file.dart';
import 'package:openpgp/openpgp.dart';
import 'package:tar/tar.dart';

class StorageService {
  late Box<Settings> settings;

  Future<List<Entry>> openStorage() async {
    final storageData = await EncryptFile.decryptFile('storage.tar.gz.aes');
    final inputStream = Stream.value(List<int>.from(storageData));
    final decodedStream = inputStream.transform(gzip.decoder);
    final List<Entry> entries = [];

    await TarReader.forEach(decodedStream, (entry) async {
      final content = await entry.contents.transform(utf8.decoder).first;

      entries.add(Entry(name: entry.header.name, content: content ));
    });

    return entries;
  }

  Future<List<Entry>> updateStorage(Iterable<Entry> newStorageData) async {
    final output = File('storage.tar.gz');
    final entries = getEntries(newStorageData);

    await entries.transform(tarWriter).transform(gzip.encoder).pipe(output.openWrite());

    await EncryptFile.encryptFile('storage.tar.gz');

    await File('storage.tar.gz').delete();

    return await openStorage();
  }

  Stream<TarEntry> getEntries(Iterable<Entry> updatedStorage) async* {
    final streamStorage = Stream.fromIterable(updatedStorage);
    const secureStorage = FlutterSecureStorage();
    final encryptionKeyString = await secureStorage.read(key: 'token');
    final encryptionKeyUint8List = base64Url.decode(encryptionKeyString!);
    final settingsBox = await Hive.openBox('settings', encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
    final publicKey = settingsBox.get('publicKey');
  
    await for (final entry in streamStorage) {
      final content = await OpenPGP.encrypt(entry.content, publicKey as String);
  
      yield TarEntry.data(
        TarHeader(name: entry.name, mode: int.parse('644', radix: 8)),
        utf8.encode(content)
      );
    }
  }
}