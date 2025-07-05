import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entities/user/model/user_dto.dart';

part 'token_payload_dto.freezed.dart';
part 'token_payload_dto.g.dart';

@freezed
class TokenPayloadDto with _$TokenPayloadDto {
  const factory TokenPayloadDto({String? accessToken, UserDto? user}) = _TokenPayloadDto;

  factory TokenPayloadDto.fromJson(Map<String, dynamic> json) => _$TokenPayloadDtoFromJson(json);
}
