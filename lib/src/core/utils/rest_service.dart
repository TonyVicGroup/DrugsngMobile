import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drugs_ng/src/core/data/models/app_responses.dart';
// import 'package:drugs_ng/src/core/utils/encryption.dart';
import 'package:drugs_ng/src/core/utils/environment.dart';
import 'package:drugs_ng/src/core/utils/log_service.dart';
import 'package:drugs_ng/src/features/auth/data/datasource/get_local_token.dart';

class RestService {
  late final Dio _client;

  RestService() {
    _client = Dio(BaseOptions(
      baseUrl: AppEnvironment.baseApiUrl,
      connectTimeout: const Duration(seconds: 20),
    ))
      ..options.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': '*/*',
      })
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (TokenPreference.hasToken()) {
              final token = TokenPreference.getToken();
              options.headers['AUTHORIZATION'] = 'Bearer $token';
            }

            /// encryption happens here
            // final encryption = Encryption.encryptString(options.data);
            // options.data = encryption.data;

            return handler.next(options);
          },
          onResponse: (response, handler) {
            /// decryption happens here
            return handler.next(response);
          },
        ),
      );
  }

  Future<ApiResponse> _handleResponse(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      final data = json.decode(utf8.decode(response.data));

      if (response.statusCode == 200) return ApiResponse(data: data);

      String msg = '';
      try {
        msg = data['responseMessage'] ?? 'Error getting response from server';
      } catch (e) {
        dLog('Parsing error: _onRequest - $e');
      }

      return ApiError(message: msg);
    } on SocketException {
      return ApiError.socket;
    } on TimeoutException catch (_) {
      return ApiError.timeout;
    } catch (e) {
      dLog('Error: _onRequest - $e');
      return ApiError.unknown;
    }
  }

  /// Get
  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic>? params,
  }) {
    return _handleResponse(() => _client.get(url, queryParameters: params));
  }

  /// Post
  Future<ApiResponse> post({
    required String url,
    Map<String, dynamic>? data,
  }) {
    return _handleResponse(() => _client.post(url, data: data));
  }

  /// Post
  Future<ApiResponse> put({
    required String url,
    Map<String, dynamic>? data,
  }) {
    return _handleResponse(() => _client.put(url, data: data));
  }
}

extension ApiResponseExt on ApiResponse {
  bool get hasError => ApiResponse is ApiError;
  ApiError get error => ApiResponse as ApiError;
}
