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
      baseUrl: 'http://drugsng.com/api/v1/',
      connectTimeout: const Duration(seconds: 20),
    ))
      ..options.headers.addAll({
        Headers.contentTypeHeader: 'application/json',
        Headers.acceptHeader: '*/*',
      })
      ..interceptors.add(
        InterceptorsWrapper(onRequest: _encryptRequestHandler),
      )
      ..options.validateStatus = (_) => true;
  }

  void _encryptRequestHandler(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (UserPreference.hasToken()) {
      final token = UserPreference.getToken();
      options.headers['AUTHORIZATION'] = 'Bearer $token';
    }

    /// encryption happens here
    final encrypted = Encryption.encryptString(jsonEncode(options.data));
    // options.data = encrypted.toMap();

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
              'Error getting response from server',
        );
      }
    } on SocketException {
      return ApiError.socket;
    } on TimeoutException {
      return ApiError.timeout;
    } catch (e, s) {
      dLog('Error: _onResponse - $e\n$s');
    }
    return ApiError.unknown;
  }

  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic>? params,
  }) {
    return _handleResponse(() => _client.get(url, queryParameters: params));
  }

  Future<ApiResponse> post({
    required String url,
    Map<String, dynamic>? data,
  }) {
    return _handleResponse(() => _client.post(url, data: data));
  }

  Future<ApiResponse> put({
    required String url,
    Map<String, dynamic>? data,
  }) {
    return _handleResponse(() => _client.put(url, data: data));
  }
}

extension ApiResponseExt on ApiResponse {
  bool get hasError => this is ApiError;
  ApiError get error => this as ApiError;
}
