import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/model/language.dart';

part 'language_detection_result.freezed.dart';

@freezed
class LanguageDetectionResult with _$LanguageDetectionResult {
  const factory LanguageDetectionResult({
    required Language? detectedLanguage,
    required double confidence,
    required String text,
  }) = _LanguageDetectionResult;
}
