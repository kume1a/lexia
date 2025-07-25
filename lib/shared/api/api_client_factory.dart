import 'package:common_network_components/common_network_components.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../features/authentication/api/auth_token_store.dart';
import '../typedefs.dart';
import 'api_client.dart';
import 'authorization_interceptor.dart';

const Duration _kTimeoutDuration = Duration(seconds: 15);

final class NetworkClientFactory {
  static ApiClient createApiClient({required Dio dio, required String apiUrl}) {
    return ApiClient(dio, baseUrl: apiUrl);
  }

  static Dio createNoInterceptorDio({required LogPrint? logPrint}) {
    final dio = Dio(
      BaseOptions(
        contentType: 'application/json',
        connectTimeout: _kTimeoutDuration,
        sendTimeout: _kTimeoutDuration,
        receiveTimeout: _kTimeoutDuration,
      ),
    );

    if (kDebugMode && logPrint != null) {
      dio.interceptors.add(PrettyLogInterceptor(logPrint: logPrint));
    }

    return dio;
  }

  static Dio createAuthenticatedDio({
    required AuthTokenStore authTokenStore,
    required VoidCallback afterExit,
    required LogPrint? logPrint,
  }) {
    final Dio dio = Dio(
      BaseOptions(
        contentType: 'application/json',
        connectTimeout: _kTimeoutDuration,
        sendTimeout: _kTimeoutDuration,
        receiveTimeout: _kTimeoutDuration,
      ),
    );

    dio.interceptors.add(AuthorizationInterceptor(authTokenStore, afterExit));

    if (kDebugMode && logPrint != null) {
      dio.interceptors.add(PrettyLogInterceptor(logPrint: logPrint));
    }

    return dio;
  }
}
