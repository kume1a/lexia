import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../entities/user/model/user.dart';
import '../../../entities/user/util/user_mapper.dart';
import '../../../shared/api/api_client.dart';
import '../../../shared/api/api_exception_message_code.dart';
import '../../../shared/dto/error_response_dto.dart';
import '../../../shared/dto/ok_dto.dart';
import '../model/auth_payload.dart';
import '../model/email_sign_in_body.dart';
import '../model/email_sign_up_body.dart';
import '../model/email_sign_up_error.dart';
import '../model/sign_in_error.dart';
import '../util/auth_mapper.dart';
import 'auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl with SafeHttpRequestWrap implements AuthRepository {
  AuthRepositoryImpl(this._apiClientProvider, this._userMapper, this._authMapper);

  final Provider<ApiClient> _apiClientProvider;
  final UserMapper _userMapper;
  final AuthMapper _authMapper;

  @override
  Future<Either<NetworkCallError, OkDto>> getAuthStatus() {
    return callCatchHandleNetworkCallError(() {
      return _apiClientProvider.get().getAuthStatus();
    });
  }

  @override
  Future<Either<SignInError, AuthPayload>> emailSignIn({required String email, required String password}) {
    return callCatch(
      () async {
        final body = EmailSignInBody(email: email, password: password);
        final tokenPayloadDto = await _apiClientProvider.get().emailSignIn(body);
        return _authMapper.tokenPayloadDtoToDomain(tokenPayloadDto);
      },
      networkError: const SignInError.network(),
      unknownError: const SignInError.unknown(),
      onResponseError: (response) {
        final errorDto = ErrorResponseDto.fromJson(response?.data);

        return switch (errorDto.error) {
          ApiExceptionMessageCode.invalidEmailOrPassword => const SignInError.invalidEmailOrPassword(),
          _ => const SignInError.unknown(),
        };
      },
    );
  }

  @override
  Future<Either<EmailSignUpError, AuthPayload>> emailSignUp({
    required String email,
    required String password,
    required String username,
  }) {
    return callCatch(
      () async {
        final body = EmailSignUpBody(email: email, password: password, username: username);
        final tokenPayloadDto = await _apiClientProvider.get().emailSignUp(body);
        return _authMapper.tokenPayloadDtoToDomain(tokenPayloadDto);
      },
      networkError: const EmailSignUpError.network(),
      unknownError: const EmailSignUpError.unknown(),
      onResponseError: (response) {
        final errorDto = ErrorResponseDto.fromJson(response?.data);

        return switch (errorDto.message) {
          ApiExceptionMessageCode.emailAlreadyExists => const EmailSignUpError.emailAlreadyInUse(),
          _ => const EmailSignUpError.unknown(),
        };
      },
    );
  }

  @override
  Future<Either<NetworkCallError, User>> getAuthUser() {
    return callCatchHandleNetworkCallError(() async {
      final userDto = await _apiClientProvider.get().getAuthUser();
      return _userMapper.dtoToDomain(userDto);
    });
  }
}
