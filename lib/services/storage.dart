import 'dart:convert';
import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/models/settings/settings.dart';
import 'package:maya/utils/encrypt_file.dart';
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
}