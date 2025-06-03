import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../entities/user/api/auth_user_info_provider.dart';
import '../model/auth_payload.dart';
import 'after_auth.dart';
import 'auth_token_store.dart';

@LazySingleton(as: AfterAuth)
class AfterAuthImpl implements AfterAuth {
  AfterAuthImpl(this._authUserInfoProvider, this._authTokenStore, this._pageNavigator);

  final AuthUserInfoProvider _authUserInfoProvider;
  final AuthTokenStore _authTokenStore;
  final PageNavigator _pageNavigator;

  @override
  Future<void> call({required AuthPayload payload}) async {
    await _authTokenStore.writeAccessToken(payload.accessToken);

    final user = payload.user;
    if (user == null) {
      Logger.root.warning('AfterSignIn.call: user is null, $payload');
      return;
    }

    await _authUserInfoProvider.write(payload.user!);

    _pageNavigator.toMain();
  }
}
