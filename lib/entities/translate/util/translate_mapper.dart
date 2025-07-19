import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/model/language.dart';
import '../model/detect_language_response_dto.dart';
import '../model/language_detection_result.dart';
import '../model/translate_response_dto.dart';
import '../model/translation_result.dart';
import '../model/translation_variant.dart';
import '../model/translation_variant_dto.dart';

@injectable
class TranslateMapper {
  TranslateMapper(this._languageMapper);

  final LanguageMapper _languageMapper;

  TranslationResult translateResponseDtoToDomain(TranslateResponseDto dto) {
    return TranslationResult(
      originalText: dto.originalText ?? '',
      languageFrom: tryMapOptional(dto.languageFrom, _languageMapper.schemaToEnum),
      languageTo: tryMapOptional(dto.languageTo, _languageMapper.schemaToEnum),
      translations: mapListOrEmpty(dto.translations, _translationVariantDtoToDomain),
    );
  }

  LanguageDetectionResult detectLanguageResponseDtoToDomain(DetectLanguageResponseDto dto) {
    return LanguageDetectionResult(
      detectedLanguage: tryMapOptional(dto.detectedLanguage, _languageMapper.schemaToEnum),
      confidence: dto.confidence ?? 0,
      text: dto.text ?? '',
    );
  }

  TranslationVariant _translationVariantDtoToDomain(TranslationVariantDto dto) {
    return TranslationVariant(text: dto.text ?? '', confidence: dto.confidence ?? 0);
  }
}
