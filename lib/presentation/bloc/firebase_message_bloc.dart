import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

/// STATE
abstract class FirebaseMessageState extends Equatable {
  @override
  List<Object> get props => [];
}

class FirebaseMessageInitState extends FirebaseMessageState {}

class FirebaseMessageGetTokenState extends FirebaseMessageState {
  final String token;

  FirebaseMessageGetTokenState({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}

class FirebaseMessageIosPermission extends FirebaseMessageState {}

class FirebaseMessageIosPermissionRequested extends FirebaseMessageState {}

class FirebaseMessageIosPermissionRejected extends FirebaseMessageState {}

class FirebaseMessageReceived extends FirebaseMessageState {}

class FirebaseMessageGetDataState extends FirebaseMessageState {
  final Map<String, dynamic> payload;
  final int time;

  FirebaseMessageGetDataState({required this.payload})
      : time = DateTime.now().millisecondsSinceEpoch,
        super();

  @override
  List<Object> get props => [payload, time];
}

class FirebaseMessageNoConnectionState extends FirebaseMessageState {}

class FirebaseMessageClickedState extends FirebaseMessageState {
  final int time;
  final String payload;

  FirebaseMessageClickedState({required this.payload})
      : time = DateTime.now().millisecondsSinceEpoch,
        super();

  @override
  List<Object> get props => [time, payload];
}

/// BLOC
class FirebaseMessageBloc extends Cubit<FirebaseMessageState> {
  final Logger _logger = Logger('FirebaseMessageBloc');
  bool isIosPermissionGranted = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final Connectivity _connectivity = Connectivity();

  FirebaseMessageBloc() : super(FirebaseMessageInitState());

  void requestIosPermission() async {
    emit(FirebaseMessageIosPermission());
    _logger.fine('configure firebase online for ios');

    NotificationSettings notificationSettings =
        await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    isIosPermissionGranted = notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized;

    _logger.fine("permission : ${isIosPermissionGranted}");
    if (isIosPermissionGranted) {
      emit(FirebaseMessageIosPermissionRequested());
    } else {
      emit(FirebaseMessageIosPermissionRejected());
    }
  }

  void configureFirebaseMessage() async {
    if ((await _connectivity.checkConnectivity()) != ConnectivityResult.none) {
      _logger.fine('configure firebase online');
      _logger.fine('configure firebase messaging listener');

      String? token = await _firebaseMessaging.getToken();

      _logger.fine('token firebase: ${token}');

      if (Platform.isIOS) {
        //check if ios notification permission is granted
        isIosPermissionGranted = await Permission.notification.isGranted;
        if (isIosPermissionGranted) configure();
      }

      if (Platform.isAndroid) configure();

      emit(FirebaseMessageGetTokenState(token: token ?? ''));
    } else {
      _logger.fine('configure firebase offline');
      emit(FirebaseMessageNoConnectionState());
    }
  }

  void configure() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification? message = event.notification;

      _logger.fine('onMessage: ${message?.body}');
      _logger.fine('onMessage data: ${event.data}');

      _logger.fine('onMessage: ${event}');
      _logger.fine('before emit');

      emit(FirebaseMessageReceived());
      // emit(FirebaseMessageGetDataState(payload: message!));

      _logger.fine('after emit');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Map<String, dynamic> message = event.data;
      _logger.fine('onMessageOpenedApp: ${message.toString()}');

      emit(FirebaseMessageReceived());
      emit(FirebaseMessageClickedState(payload: jsonEncode(message)));
    });
  }

  void notificationClick(String payload) {
    emit(FirebaseMessageClickedState(payload: payload));
  }

  Future<void> reset() async {
    await FirebaseMessaging.instance.deleteToken();
    configureFirebaseMessage();
  }

  static Future<dynamic>? onBackgroundMessage(Map<String, dynamic> message) {
    Logger('FirebaseMessageBloc').fine('onBackgroundMessage: $message');
    return null;
  }
}
