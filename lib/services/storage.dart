import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/utils/encrypt_file.dart';
import 'package:tar/tar.dart';

class StorageService {
  late Box<Settings> settings;

  Future<List<TarEntry>> openStorage() async {
    final storageData = await EncryptFile.decryptFile('storage.tar.gz.aes');
    final inputStream = Stream.value(List<int>.from(storageData));
    final decodedStream = inputStream.transform(gzip.decoder);
    final List<TarEntry> entries = [];

    await TarReader.forEach(decodedStream, (entry) {
      entries.add(entry);
    });

    return entries;
  }
}