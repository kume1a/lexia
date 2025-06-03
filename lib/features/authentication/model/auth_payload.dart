import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entities/user/model/user.dart';

part 'auth_payload.freezed.dart';

@freezed
class AuthPayload with _$AuthPayload {
  const factory AuthPayload({required String accessToken, required User? user}) = _AuthPayload;
}
