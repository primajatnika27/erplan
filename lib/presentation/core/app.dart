import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class App {
  late String firebaseToken;
  late Dio client;
  late Dio clientAuth;
  late String accessToken;

  static App get main => Modular.get<App>();

  static Future<void> init() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<bool> isOnline() async {
    return await Connectivity().checkConnectivity() != ConnectivityResult.none;
  }
}
