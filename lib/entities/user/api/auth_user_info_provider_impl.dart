import 'package:common_network_components/common_network_components.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../entities/user/model/user.dart';
import '../../../features/authentication/api/auth_token_store.dart';
import 'auth_user_info_provider.dart';

@LazySingleton(as: AuthUserInfoProvider)
class AuthUserInfoProviderImpl implements AuthUserInfoProvider {
  AuthUserInfoProviderImpl(this._authTokenStore, this._sharedPreferences);

  final AuthTokenStore _authTokenStore;
  final SharedPreferences _sharedPreferences;

  static const _keyAuthUserId = 'auth_user_id';
  static const _keyAuthUserCreatedAt = 'auth_user_created_at';
  static const _keyAuthUserUsername = 'auth_user_username';
  static const _keyAuthUserEmail = 'auth_user_email';

  @override
  Future<String?> getId() async {
    final accessToken = await _authTokenStore.readAccessToken();

    if (accessToken == null) {
      return null;
    }

    try {
      final payload = JwtDecoder.parseJwt(accessToken);

      if (!payload.containsKey('userId')) {
        return null;
      }

      return payload['userId'] as String?;
    } catch (e) {
      Logger.root.severe(e);
    }

    return null;
  }

  @override
  Future<void> clear() {
    return Future.wait([
      _sharedPreferences.remove(_keyAuthUserId),
      _sharedPreferences.remove(_keyAuthUserCreatedAt),
      _sharedPreferences.remove(_keyAuthUserUsername),
      _sharedPreferences.remove(_keyAuthUserEmail),
    ]);
  }

  @override
  Future<User?> read() {
    final userId = _sharedPreferences.getString(_keyAuthUserId);
    final createdAtMillis = _sharedPreferences.getInt(_keyAuthUserCreatedAt);
    final name = _sharedPreferences.getString(_keyAuthUserUsername);
    final email = _sharedPreferences.getString(_keyAuthUserEmail);

    if (userId == null || name == null || email == null) {
      return Future.value();
    }

    return Future.value(
      User(id: userId, createdAt: tryMapDateMillis(createdAtMillis), username: name, email: email),
    );
  }

  @override
  Future<void> write(User user) {
    return Future.wait([
      _sharedPreferences.setString(_keyAuthUserId, user.id),
      if (user.createdAt != null)
        _sharedPreferences.setInt(_keyAuthUserCreatedAt, user.createdAt!.millisecondsSinceEpoch),
      if (user.username != null) _sharedPreferences.setString(_keyAuthUserUsername, user.username!),
      _sharedPreferences.setString(_keyAuthUserEmail, user.email),
    ]);
  }
}
