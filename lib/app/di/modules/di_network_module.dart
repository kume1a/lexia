import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../features/authentication/api/after_sign_out.dart';
import '../../../features/authentication/api/auth_token_store.dart';
import '../../../shared/api/api_client_factory.dart';
import '../injection_tokens.dart';

@module
abstract class DiSonifyClientModule {
  @lazySingleton
  @Named(InjectionToken.authenticatedDio)
  Dio authenticatedDio(AuthTokenStore authTokenStore, AfterSignOut afterSignOut) {
    return NetworkClientFactory.createAuthenticatedDio(
      authTokenStore: authTokenStore,
      afterExit: afterSignOut.call,
      logPrint: Logger.root.finest,
      // logPrint: Logger.root.finest,
    );
  }

  @lazySingleton
  @Named(InjectionToken.noInterceptorDio)
  Dio dio() {
    return NetworkClientFactory.createNoInterceptorDio(
      logPrint: Logger.root.finest,
      // logPrint: null,
    );
  }
}
