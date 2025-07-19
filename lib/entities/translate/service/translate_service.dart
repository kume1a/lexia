import 'package:common_models/common_models.dart';

import '../../../shared/model/language.dart';
import '../model/language_detection_result.dart';
import '../model/translation_result.dart';

abstract class TranslateService {
  Future<Either<NetworkCallError, TranslationResult>> translateText({
    required String text,
    required Language languageFrom,
    required Language languageTo,
  });

  Future<Either<NetworkCallError, LanguageDetectionResult>> detectLanguage({required String text});

  Future<Either<NetworkCallError, List<Language>>> getSupportedLanguages();
}
