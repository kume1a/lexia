import 'package:freezed_annotation/freezed_annotation.dart';

part 'ok_dto.g.dart';
part 'ok_dto.freezed.dart';

@freezed
class OkDto with _$OkDto {
  const factory OkDto({required bool ok}) = _OkDto;

  factory OkDto.fromJson(Map<String, dynamic> json) => _$OkDtoFromJson(json);
}
