import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure() : super();

  @override
  List<Object> get props => const <dynamic>[];
}

// General failures
class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}
