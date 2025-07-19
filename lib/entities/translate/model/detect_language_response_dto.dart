import 'package:freezed_annotation/freezed_annotation.dart';

part 'detect_language_response_dto.freezed.dart';
part 'detect_language_response_dto.g.dart';

@freezed
class DetectLanguageResponseDto with _$DetectLanguageResponseDto {
  const factory DetectLanguageResponseDto({String? detectedLanguage, double? confidence, String? text}) =
      _DetectLanguageResponseDto;

  factory DetectLanguageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DetectLanguageResponseDtoFromJson(json);
}
