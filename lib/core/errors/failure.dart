import 'package:equatable/equatable.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(statusCode is int || statusCode is String,
            'Status code cannot be a ${statusCode.runtimeType}');
  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ChaceFailure extends Failure {
  ChaceFailure({required super.message, required super.statusCode});
}
