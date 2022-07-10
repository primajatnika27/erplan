import 'package:equatable/equatable.dart';

/// Abstract class of failure
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class NoInternetFailure extends Failure {}

class RequestFailure extends Failure {
  /// code from server
  final int code;

  /// message from server
  final String message;

  /// data from server
  final Object? data;

  RequestFailure({required this.code, required this.message, this.data});

  @override
  List<Object> get props => [code, message, data ?? ''];
}

class CacheFailure extends Failure {}
