import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;

  const AppError(this.message);

  static const unknown = AppError('An unknown error has occured');

  @override
  List<Object?> get props => [message];
}

class ApiResponse {
  final Map<String, dynamic>? data;
  final int statusCode;

  const ApiResponse({this.data, required this.statusCode});
}

class ApiError extends ApiResponse implements AppError {
  @override
  final String message;

  const ApiError({this.message = '', super.data, required super.statusCode});

  static const socket = ApiError(
    message: 'You have unstable internet connection',
    statusCode: 408,
  );
  static const timeout = ApiError(
    message: 'Your connection has timed out. Please try again!',
    statusCode: 450,
  );
  static const unauthorized = ApiError(
    message: 'Your session has expired.\nYou need to log in again',
    statusCode: 401,
  );
  static const unknown = ApiError(
    message: 'There was a problem performing this action',
    statusCode: 500,
  );

  @override
  List<Object?> get props => [message, data, statusCode];

  @override
  bool? get stringify => null;
}
