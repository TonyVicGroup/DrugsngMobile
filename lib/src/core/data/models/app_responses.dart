import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;

  const AppError(this.message);

  @override
  List<Object?> get props => [message];
}

class ApiResponse {
  final Map<String, dynamic>? data;

  const ApiResponse({this.data});
}

class ApiError extends ApiResponse implements AppError {
  @override
  final String message;

  const ApiError({this.message = '', super.data});

  static const unknown = ApiError(message: 'An unknown error has occured');
  static const socket = ApiError(message: 'No internet connection');
  static const timeout = ApiError(
    message: 'The connection has timed out. Please try again!',
  );

  @override
  List<Object?> get props => [message, data];

  @override
  bool? get stringify => null;
}
