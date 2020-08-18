import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

//General Exceptions
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
