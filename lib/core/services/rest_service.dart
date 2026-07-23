import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:drugs_ng/core/error/app_responses.dart';
import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/features/auth/data/datasource/get_local_token.dart';

class RestService {
  final _errorStream = StreamController<Response<dynamic>>.broadcast();
  Stream<Response<dynamic>> get errorStream => _errorStream.stream;

  late final Dio _client;
  late final Dio _cachedClient;

  RestService({String? baseUrl}) {
    _client =
        Dio(
            BaseOptions(
              baseUrl: baseUrl ?? '',
              connectTimeout: const Duration(seconds: 25),
              sendTimeout: const Duration(seconds: 25),
              receiveTimeout: const Duration(seconds: 25),
            ),
          )
          ..options.headers.addAll({
            Headers.contentTypeHeader: Headers.jsonContentType,
            Headers.acceptHeader: Headers.textPlainContentType,
          })
          ..interceptors.addAll([
            InterceptorsWrapper(onRequest: _handleUserTokenOnRequest),
            // InterceptorsWrapper(onRequest: _encryptRequest),
          ])
          ..options.validateStatus = (_) => true;

    // Cached client
    final cacheOptions = CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.request,
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
    );

    _cachedClient =
        Dio()..interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  void _handleUserTokenOnRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['accept'] ??= 'application/json';
    options.headers['Content-Type'] ??= 'application/json';
    final token = UserPreference.getToken();
    if (token?.isNotEmpty ?? false) {
      options.headers['AUTHORIZATION'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  // void _encryptRequest(
  //   RequestOptions options,
  //   RequestInterceptorHandler handler,
  // ) {
  //   /// encryption happens here
  //   final encrypted = Encryption.encryptString(jsonEncode(options.data));
  //   options.data = encrypted.toMap();
  //   return handler.next(options);
  // }

  Future<ApiResponse> _handleResponse(
    Future<Response<dynamic>> Function() request,
  ) async {
    try {
      final response = await request();

      Map<String, dynamic> data;
      try {
        data = Map<String, dynamic>.from(response.data as Map);
      } catch (e) {
        data = {};
      }

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return ApiResponse(data: data, statusCode: response.statusCode!);
      }

      dLog('API error: - $response');

      _errorStream.add(response);

      if (response.statusCode == 401) return ApiError.unauthorized;

      // if (response.statusCode == 400) {
      return ApiError(
        message:
            data['responseMessage'] ??
            data['ResponseMessage'] ??
            data['title'] ??
            response.statusMessage ??
            ApiError.unknown.message,
        statusCode: response.statusCode ?? 500,
      );
      // }
    } on TimeoutException catch (_) {
      return ApiError.timeout;
    } on DioException catch (e) {
      if (e.response != null) {
        return ApiError(
          message:
              e.response!.data['responseMessage'] ??
              e.response!.data['ResponseMessage'] ??
              e.response!.data['title'] ??
              e.response!.statusMessage ??
              ApiError.unknown.message,
          statusCode: e.response!.statusCode ?? 500,
        );
      }
      if (e.error is SocketException) return ApiError.socket;
      if (e.type == DioExceptionType.connectionTimeout) return ApiError.timeout;
      if (e.type == DioExceptionType.receiveTimeout) return ApiError.timeout;
      if (e.type == DioExceptionType.sendTimeout) return ApiError.timeout;
      dLog('DioException: - $e');
      return ApiError(
        message: e.message ?? 'An error occured',
        statusCode: 500,
      );
    } catch (e, s) {
      dLog('API unknown Exception: - $e\n$s');
    }
    return ApiError.unknown;
  }

  Future<ApiResponse> get({
    required String path,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    bool useCache = false,
  }) {
    final headersOptions = headers != null ? Options(headers: headers) : null;
    if (useCache) {
      return _handleResponse(
        () => _cachedClient.get(
          path,
          queryParameters: params,
          options: headersOptions,
        ),
      );
    } else {
      return _handleResponse(
        () =>
            _client.get(path, queryParameters: params, options: headersOptions),
      );
    }
  }

  Future<ApiResponse> post({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool useCache = false,
  }) {
    final headersOptions = headers != null ? Options(headers: headers) : null;
    if (useCache) {
      return _handleResponse(
        () => _cachedClient.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: headersOptions,
        ),
      );
    } else {
      return _handleResponse(
        () => _client.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: headersOptions,
        ),
      );
    }
  }

  Future<ApiResponse> postFormData({required String path, FormData? data}) {
    return _handleResponse(() => _client.post(path, data: data));
  }

  Future<ApiResponse> patch({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool useCache = false,
  }) {
    final headersOptions = headers != null ? Options(headers: headers) : null;
    if (useCache) {
      return _handleResponse(
        () => _cachedClient.patch(path, data: data, options: headersOptions),
      );
    } else {
      return _handleResponse(
        () => _client.patch(path, data: data, options: headersOptions),
      );
    }
  }

  Future<ApiResponse> put({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool useCache = false,
  }) {
    final headersOptions = headers != null ? Options(headers: headers) : null;
    if (useCache) {
      return _handleResponse(
        () => _cachedClient.put(path, data: data, options: headersOptions),
      );
    } else {
      return _handleResponse(
        () => _client.put(path, data: data, options: headersOptions),
      );
    }
  }

  Future<ApiResponse> putFormData({
    required String path,
    FormData? data,
    Map<String, dynamic>? headers,
    bool useCache = false,
  }) {
    final headersOptions = headers != null ? Options(headers: headers) : null;
    if (useCache) {
      return _handleResponse(
        () => _cachedClient.put(path, data: data, options: headersOptions),
      );
    } else {
      return _handleResponse(
        () => _client.put(path, data: data, options: headersOptions),
      );
    }
  }

  Future<ApiResponse> delete({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    bool useCache = false,
  }) {
    final headersOptions = headers != null ? Options(headers: headers) : null;
    if (useCache) {
      return _handleResponse(
        () => _cachedClient.delete(path, data: data, options: headersOptions),
      );
    } else {
      return _handleResponse(
        () => _client.delete(path, data: data, options: headersOptions),
      );
    }
  }
}

extension ApiResponseExt on ApiResponse {
  bool get hasError => this is ApiError;
  ApiError get error => this as ApiError;
}
