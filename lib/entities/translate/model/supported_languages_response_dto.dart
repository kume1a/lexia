import 'package:freezed_annotation/freezed_annotation.dart';

part 'supported_languages_response_dto.freezed.dart';
part 'supported_languages_response_dto.g.dart';

@freezed
class SupportedLanguagesResponseDto with _$SupportedLanguagesResponseDto {
  const factory SupportedLanguagesResponseDto({List<String>? languages}) = _SupportedLanguagesResponseDto;

  factory SupportedLanguagesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SupportedLanguagesResponseDtoFromJson(json);
}
