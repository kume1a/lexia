import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../model/auth_payload.dart';
import '../model/sign_up_error.dart';
import 'auth_service.dart';

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  @override
  Future<Either<SignUpError, AuthPayload>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => right(AuthPayload(accessToken: 'fake_access_token', userId: 'fake_user_id', email: email)),
    );
  }

  @override
  Future<Either<SignUpError, AuthPayload>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => right(AuthPayload(accessToken: 'fake_access_token', userId: 'fake_user_id', email: email)),
    );
  }

  @override
  Future<void> signOut() {
    return Future.delayed(const Duration(seconds: 2));
  }
}
