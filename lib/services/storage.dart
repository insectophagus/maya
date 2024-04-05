import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/utils/encrypt_file.dart';
import 'package:tar/tar.dart';

class StorageService {
  late Box<Settings> settings;

  Future<List<TarEntry>> openStorage() async {
    final storagePath = await EncryptFile.decryptFile('storage.tar.gz.aes');
    final inputStream = File(storagePath).openRead();
    final decodedStream = inputStream.transform(gzip.decoder);
    List<TarEntry> entries = [];

    await TarReader.forEach(decodedStream, (entry) {
      entries.add(entry);
    });

    return entries;
  }
}