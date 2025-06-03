import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_error.freezed.dart';

@freezed
class SignUpError with _$SignUpError {
  const factory SignUpError.network() = _network;

  const factory SignUpError.unknown() = _unknown;

  const factory SignUpError.emailAlreadyInUse() = _emailAlreadyInUse;

  const factory SignUpError.invalidEmailOrPassword() = _invalidEmail;
}
