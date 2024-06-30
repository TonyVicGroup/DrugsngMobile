class AppError {
  final String message;

  AppError(this.message);
}

class ApiResponse {
  final Map<String, dynamic>? data;

  ApiResponse({this.data});
}

class ApiError extends ApiResponse implements AppError {
  @override
  final String message;

  ApiError({this.message = '', super.data});
}
