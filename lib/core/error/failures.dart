import 'package:equatable/equatable.dart';

// Failure chuttauna (local databasee ho ki api failure ho bhanyera)
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// Local Database Failure
class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({
    String message = 'Local database operation failed',
}) : super(message);
}

// API Failure with status code
class ApiFailure extends Failure {
  final int? statusCode;

  const ApiFailure({
    required String message,
    this.statusCode
  }) : super(message);

  @override
  List<Object?> get props => [message, statusCode];
}