import 'package:common_models/common_models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'auth_token_store.dart';

@LazySingleton(as: AuthTokenStore)
class SecureStoreageTokenStoreImpl with ResultWrap implements AuthTokenStore {
  SecureStoreageTokenStoreImpl(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  static const String _keyAccessToken = 'key_access_token';

  @override
  Future<void> clear() async {
    await wrapWithEmptyResult(() => _secureStorage.delete(key: _keyAccessToken));
  }

  @override
  Future<String?> readAccessToken() async {
    final res = await wrapWithResult(() => _secureStorage.read(key: _keyAccessToken));

    return res.dataOrNull;
  }

  @override
  Future<void> writeAccessToken(String accessToken) async {
    await wrapWithEmptyResult(() => _secureStorage.write(key: _keyAccessToken, value: accessToken));
  }

  @override
  Future<bool> hasAccessToken() async {
    final res = await wrapWithResult(() => _secureStorage.read(key: _keyAccessToken));

    return res.dataOrNull != null;
  }
}
