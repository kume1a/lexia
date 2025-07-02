import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_sign_up_error.freezed.dart';

@freezed
class EmailSignUpError with _$EmailSignUpError {
  const factory EmailSignUpError.network() = _network;

  const factory EmailSignUpError.unknown() = _unknown;

  const factory EmailSignUpError.emailAlreadyInUse() = _emailAlreadyInUse;
}
