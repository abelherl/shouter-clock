import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Throw this if you want to get server exception
class ServerException extends Equatable implements Exception {
  /// code from server
  final int code;

  /// message from server
  final String message;

  /// data from server
  final String data;

  ServerException({@required this.code, @required this.message, this.data});

  @override
  List<Object> get props => [code, message, data];
}

/// Throw this if you want to get cache exception
class CacheException extends Equatable implements Exception {
  @override
  List<Object> get props => [];
}
