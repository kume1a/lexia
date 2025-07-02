import 'package:common_utilities/common_utilities.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../app/di/injection_tokens.dart';
import '../../../shared/api/api_client.dart';
import '../../../shared/api/api_client_factory.dart';
import 'dynamic_api_url_provider.dart';

@LazySingleton(as: Provider<ApiClient>)
class DynamicApiClientProvider implements Provider<ApiClient> {
  DynamicApiClientProvider(this._dynamicApiUrlProvider, @Named(InjectionToken.authenticatedDio) this.dio);

  final DynamicApiUrlProvider _dynamicApiUrlProvider;
  final Dio dio;

  final Map<String, ApiClient> _cache = {};

  @override
  ApiClient get() {
    final apiUrl = _dynamicApiUrlProvider.get();

    return _cache.putIfAbsent(apiUrl, () => NetworkClientFactory.createApiClient(dio: dio, apiUrl: apiUrl));
  }
}
