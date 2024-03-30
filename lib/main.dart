import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import './app.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const App());
}