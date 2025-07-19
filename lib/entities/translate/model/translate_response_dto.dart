import 'package:freezed_annotation/freezed_annotation.dart';

import 'translation_variant_dto.dart';

part 'translate_response_dto.freezed.dart';
part 'translate_response_dto.g.dart';

@freezed
class TranslateResponseDto with _$TranslateResponseDto {
  const factory TranslateResponseDto({
    String? originalText,
    String? languageFrom,
    String? languageTo,
    List<TranslationVariantDto>? translations,
  }) = _TranslateResponseDto;

  factory TranslateResponseDto.fromJson(Map<String, dynamic> json) => _$TranslateResponseDtoFromJson(json);
}
