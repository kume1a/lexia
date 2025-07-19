import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/model/language.dart';
import '../api/translate_repository.dart';
import '../model/language_detection_result.dart';
import '../model/translation_result.dart';
import 'translate_service.dart';

@Injectable(as: TranslateService)
class TranslateServiceImpl implements TranslateService {
  TranslateServiceImpl(this._translateRepository);

  final TranslateRepository _translateRepository;

  @override
  Future<Either<NetworkCallError, TranslationResult>> translateText({
    required String text,
    required Language languageFrom,
    required Language languageTo,
  }) async {
    return _translateRepository.translateText(text: text, languageFrom: languageFrom, languageTo: languageTo);
  }

  @override
  Future<Either<NetworkCallError, LanguageDetectionResult>> detectLanguage({required String text}) async {
    return _translateRepository.detectLanguage(text: text);
  }

  @override
  Future<Either<NetworkCallError, List<Language>>> getSupportedLanguages() {
    return _translateRepository.getSupportedLanguages();
  }
}
