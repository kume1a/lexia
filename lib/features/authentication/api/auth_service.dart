import 'package:common_models/common_models.dart';

import '../model/auth_payload.dart';
import '../model/email_sign_up_error.dart';

abstract interface class AuthService {
  Future<Either<EmailSignUpError, AuthPayload>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<EmailSignUpError, AuthPayload>> signUpWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  });
}
