import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/api/api_endpoints.dart';
import 'package:match_aura/core/services/storage/user_session_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final userSessionService = ref.read(UserSessionServiceProvider);
  return ApiClient(userSessionService: userSessionService);
});

class ApiClient {
  final UserSessionService _userSessionService;
  late final Dio _dio;

  ApiClient({required UserSessionService userSessionService})
      : _userSessionService = userSessionService {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectionTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Attach interceptors
    _dio.interceptors.add(_AuthInterceptor(_userSessionService));

    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
        retryEvaluator: (error, attempt) {
          return error.type == DioExceptionType.sendTimeout ||
              error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.connectionError;
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }
  }

  Dio get dio => _dio;

  // Basic CRUD wrappers
  Future<Response> get(String path,
          {Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.get(path, queryParameters: queryParameters, options: options);

  Future<Response> post(String path,
          {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.post(path, data: data, queryParameters: queryParameters, options: options);

  Future<Response> put(String path,
          {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.put(path, data: data, queryParameters: queryParameters, options: options);

  Future<Response> delete(String path,
          {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.delete(path, data: data, queryParameters: queryParameters, options: options);

  Future<Response> uploadFile(String path,
          {required FormData formData, Options? options, ProgressCallback? onSendProgress}) =>
      _dio.post(path, data: formData, options: options, onSendProgress: onSendProgress);
}


class _AuthInterceptor extends Interceptor {
  final UserSessionService _userSessionService;

  _AuthInterceptor(this._userSessionService);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Skip auth for public endpoints
    final publicEndpoints = [
      ApiEndpoints.users,
      ApiEndpoints.users, // signup endpoint if needed
    ];

    final isPublic = publicEndpoints.any((endpoint) => options.path.endsWith(endpoint));

    if (!isPublic) {
      final token = _userSessionService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired or invalid
      await _userSessionService.clearUserSession();
      // You can add navigation to login here if needed
    }
    handler.next(err);
  }
}
