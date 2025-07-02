import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.g.dart';
part 'user_dto.freezed.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required DateTime createdAt,
    required String username,
    required String email,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
