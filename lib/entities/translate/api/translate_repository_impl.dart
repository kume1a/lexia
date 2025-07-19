import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/api/api_client.dart';
import '../../../shared/model/language.dart';
import '../model/detect_language_request_body.dart';
import '../model/language_detection_result.dart';
import '../model/translate_request_body.dart';
import '../model/translation_result.dart';
import '../util/translate_mapper.dart';
import 'translate_repository.dart';

@Injectable(as: TranslateRepository)
class TranslateRepositoryImpl with SafeHttpRequestWrap implements TranslateRepository {
  TranslateRepositoryImpl(this._apiClientProvider, this._translateMapper, this._languageMapper);

  final Provider<ApiClient> _apiClientProvider;
  final TranslateMapper _translateMapper;
  final LanguageMapper _languageMapper;

  @override
  Future<Either<NetworkCallError, TranslationResult>> translateText({
    required String text,
    required Language languageFrom,
    required Language languageTo,
  }) {
    return callCatchHandleNetworkCallError(() async {
      final body = TranslateRequestBody(
        text: text,
        languageFrom: _languageMapper.enumToSchema(languageFrom) ?? '',
        languageTo: _languageMapper.enumToSchema(languageTo) ?? '',
      );

      final responseDto = await _apiClientProvider.get().translateText(body);

      return _translateMapper.translateResponseDtoToDomain(responseDto);
    });
  }

  @override
  Future<Either<NetworkCallError, LanguageDetectionResult>> detectLanguage({required String text}) {
    return callCatchHandleNetworkCallError(() async {
      final body = DetectLanguageRequestBody(text: text);

      final responseDto = await _apiClientProvider.get().detectLanguage(body);

      return _translateMapper.detectLanguageResponseDtoToDomain(responseDto);
    });
  }

  @override
  Future<Either<NetworkCallError, List<Language>>> getSupportedLanguages() {
    return callCatchHandleNetworkCallError(() async {
      final responseDto = await _apiClientProvider.get().getSupportedLanguages();

      return responseDto.languages?.map(_languageMapper.schemaToEnum).nonNulls.toList() ?? [];
    });
  }
}
