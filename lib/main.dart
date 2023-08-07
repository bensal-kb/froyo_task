import 'package:flutter/material.dart';
import 'package:foyer/app.dart';
import 'package:foyer/res/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const App());
}