import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drugs_ng/src/core/data/models/app_responses.dart';
import 'package:drugs_ng/src/core/utils/encryption.dart';
import 'package:drugs_ng/src/core/utils/log_service.dart';
import 'package:drugs_ng/src/features/auth/data/datasource/get_local_token.dart';

class RestService {
  late final Dio _client;

  RestService() {
    _client = Dio(BaseOptions(
      baseUrl: 'https://drugsng.com/api/v1/',
      connectTimeout: const Duration(seconds: 20),
    ))
      ..options.headers.addAll({
        Headers.contentTypeHeader: Headers.jsonContentType,
        Headers.acceptHeader: Headers.textPlainContentType,
      })
      ..interceptors.addAll([
        InterceptorsWrapper(onRequest: _handleUserTokenOnRequest),
        // InterceptorsWrapper(onRequest: _encryptRequest),
      ])
      ..options.validateStatus = (_) => true;
  }

  void _handleUserTokenOnRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = UserPreference.getToken();
    if (token?.isNotEmpty ?? false) {
      options.headers['AUTHORIZATION'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  void _encryptRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    /// encryption happens here
    final encrypted = Encryption.encryptString(jsonEncode(options.data));
    options.data = encrypted.toMap();

    return handler.next(options);
  }

  Future<ApiResponse> _handleResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      final data = Map<String, dynamic>.from(response.data);

      if (response.statusCode == 200) return ApiResponse(data: data);
      if (response.statusCode == 400) {
        return ApiError(
          message: data['responseMessage'] ??
              data['title'] ??
              'There was a problem with your request',
        );
      }
      dLog('API response error: - ${response.data}');
    } on SocketException {
      return ApiError.socket;
    } on TimeoutException {
      return ApiError.timeout;
    } catch (e, s) {
      dLog('API request Exception: - $e\n$s');
    }
    return ApiError.unknown;
  }

  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? params,
  }) {
    return _handleResponse(() => _client.get(path, queryParameters: params));
  }

  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? data,
  }) {
    return _handleResponse(() => _client.post(path, data: data));
  }

  Future<ApiResponse> put({
    required String path,
    Map<String, dynamic>? data,
  }) {
    return _handleResponse(() => _client.put(path, data: data));
  }
}

extension ApiResponseExt on ApiResponse {
  bool get hasError => this is ApiError;
  ApiError get error => this as ApiError;
}
