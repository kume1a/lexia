import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_error.freezed.dart';

@freezed
class SignInError with _$SignInError {
  const factory SignInError.network() = _network;

  const factory SignInError.unknown() = _unknown;

  const factory SignInError.invalidEmailOrPassword() = _invalidEmailOrPassword;
}
