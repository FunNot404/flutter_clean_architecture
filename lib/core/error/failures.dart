import 'package:equatable/equatable.dart';

class CacheFailure extends Failure {
  const CacheFailure();
  @override
  List<Object?> get props => <Object?>[];
}

abstract class Failure extends Equatable {
  // ignore: avoid_unused_constructor_parameters
  const Failure([List<dynamic> props = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  const ServerFailure();
  @override
  List<Object?> get props => <Object?>[];
}
