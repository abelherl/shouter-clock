import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'failure.dart';

/// Abstract class of use case, that implements callable class in dart
/// See [https://dart.dev/guides/language/language-tour#callable-classes]
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Default no params if the use case class does not need any param
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
