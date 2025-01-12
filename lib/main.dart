import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memmatch/core/management/theme/theme_mode_adapter.dart';
import 'package:memmatch/injector.dart';
import 'package:memmatch/core/management/session/session_handler.dart';
import 'package:memmatch/modules/launcher/views/launcher_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ThemeModeAdapter());

  serviceLocator();
  await SessionHandler();
  runApp(const LauncherScreen());
}
