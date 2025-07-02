import 'package:common_models/common_models.dart';

import '../../../entities/user/model/user.dart';
import '../../../shared/dto/ok_dto.dart';
import '../model/auth_payload.dart';
import '../model/email_sign_up_error.dart';
import '../model/sign_in_error.dart';

abstract class AuthRepository {
  Future<Either<NetworkCallError, OkDto>> getAuthStatus();
  Future<Either<SignInError, AuthPayload>> emailSignIn({required String email, required String password});
  Future<Either<EmailSignUpError, AuthPayload>> emailSignUp({
    required String email,
    required String password,
    required String username,
  });
  Future<Either<NetworkCallError, User>> getAuthUser();
}
