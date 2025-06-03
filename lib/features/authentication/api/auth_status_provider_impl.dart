import 'auth_status_provider.dart';
import 'auth_token_store.dart';

class AuthStatusProviderImpl implements AuthStatusProvider {
  AuthStatusProviderImpl(this._authTokenStore);

  final AuthTokenStore _authTokenStore;

  @override
  Future<bool> get() {
    return _authTokenStore.hasAccessToken();
  }
}
