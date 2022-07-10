import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logging/logging.dart';

import 'presentation/config/module_config.dart';
import 'presentation/core/app.dart';
import 'presentation/core/main_app.dart';

Future<Null> main() async {
  // Activate logger in root
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
      '${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}',
    );
  });

  // ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Active Flipper in root
  FlipperClient flipperClient = FlipperClient.getDefault();
  flipperClient.addPlugin(FlipperNetworkPlugin());
  flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
  flipperClient.start();

  await Firebase.initializeApp();

  // wait initialized
  await App.init();

  runApp(
    ModularApp(
      module: AppModule(),
      child: MainApp(),
    ),
  );
}
