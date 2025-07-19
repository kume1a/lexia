import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/model/language.dart';
import 'translation_variant.dart';

part 'translation_result.freezed.dart';

@freezed
class TranslationResult with _$TranslationResult {
  const factory TranslationResult({
    required String originalText,
    required Language? languageFrom,
    required Language? languageTo,
    required List<TranslationVariant> translations,
  }) = _TranslationResult;
}
