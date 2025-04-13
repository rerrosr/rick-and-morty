import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

