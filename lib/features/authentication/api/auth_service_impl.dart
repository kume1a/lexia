import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../entities/user/model/user.dart';
import '../model/auth_payload.dart';
import '../model/sign_up_error.dart';
import 'auth_service.dart';

AuthPayload fakeAuthPayload({required String username, required String email}) => AuthPayload(
  accessToken: 'fake_access_token',
  user: User(id: 'fake_user_id', createdAt: DateTime.now(), username: username, email: email),
);

@LazySingleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  @override
  Future<Either<SignUpError, AuthPayload>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => right(fakeAuthPayload(username: 'fake_username', email: email)),
    );
  }

  @override
  Future<Either<SignUpError, AuthPayload>> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => right(fakeAuthPayload(username: username, email: email)),
    );
  }
}
