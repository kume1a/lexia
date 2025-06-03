import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../entities/user/api/auth_user_info_provider.dart';
import 'after_sign_out.dart';
import 'auth_token_store.dart';

@LazySingleton(as: AfterSignOut)
class AfterSignOutImpl implements AfterSignOut {
  AfterSignOutImpl(this._pageNavigator, this._authTokenStore, this._authUserInfoProvider);

  final PageNavigator _pageNavigator;
  final AuthTokenStore _authTokenStore;
  final AuthUserInfoProvider _authUserInfoProvider;

  @override
  Future<void> call() async {
    await Future.wait([_authTokenStore.clear(), _authUserInfoProvider.clear()]);

    _pageNavigator.toSignIn();
  }
}
