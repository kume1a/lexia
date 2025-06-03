import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_payload.freezed.dart';

@freezed
class AuthPayload with _$AuthPayload {
  const factory AuthPayload({required String accessToken, required String userId, required String email}) =
      _AuthPayload;
}
