import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_variant_dto.freezed.dart';
part 'translation_variant_dto.g.dart';

@freezed
class TranslationVariantDto with _$TranslationVariantDto {
  const factory TranslationVariantDto({String? text, double? confidence}) = _TranslationVariantDto;

  factory TranslationVariantDto.fromJson(Map<String, dynamic> json) => _$TranslationVariantDtoFromJson(json);
}
