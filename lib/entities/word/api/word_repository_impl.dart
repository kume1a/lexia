import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/api/api_client.dart';
import '../model/create_word_body.dart';
import '../model/update_word_body.dart';
import '../model/word.dart';
import '../util/word_mapper.dart';
import 'word_repository.dart';

@Injectable(as: WordRepository)
class WordRepositoryImpl with SafeHttpRequestWrap implements WordRepository {
  WordRepositoryImpl(this._apiClientProvider, this._wordMapper);

  final Provider<ApiClient> _apiClientProvider;
  final WordMapper _wordMapper;

  @override
  Future<Either<NetworkCallError, Word>> createWord({
    required String folderId,
    required String text,
    required String definition,
  }) {
    return callCatchHandleNetworkCallError(() async {
      final body = CreateWordBody(folderId: folderId, text: text, definition: definition);
      final wordWithFolderDto = await _apiClientProvider.get().createWord(body);
      return _wordMapper.wordWithFolderDtoToDomain(wordWithFolderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, Word>> getWordById(String wordId) {
    return callCatchHandleNetworkCallError(() async {
      final wordWithFolderDto = await _apiClientProvider.get().getWordById(wordId);
      return _wordMapper.wordWithFolderDtoToDomain(wordWithFolderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, Word>> updateWord({
    required String wordId,
    required String text,
    required String definition,
  }) {
    return callCatchHandleNetworkCallError(() async {
      final body = UpdateWordBody(text: text, definition: definition);
      final wordWithFolderDto = await _apiClientProvider.get().updateWord(wordId, body);
      return _wordMapper.wordWithFolderDtoToDomain(wordWithFolderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, void>> deleteWord(String wordId) {
    return callCatchHandleNetworkCallError(() async {
      await _apiClientProvider.get().deleteWord(wordId);
    });
  }

  @override
  Future<Either<NetworkCallError, List<Word>>> getWordsByFolder(String folderId) {
    return callCatchHandleNetworkCallError(() async {
      final wordDtos = await _apiClientProvider.get().getWordsByFolder(folderId);
      return wordDtos.map((dto) => _wordMapper.dtoToDomain(dto)).toList();
    });
  }
}
