import 'package:common_models/common_models.dart';

import '../model/word.dart';

abstract class WordRepository {
  Future<Either<NetworkCallError, Word>> createWord({
    required String folderId,
    required String text,
    required String definition,
  });
  Future<Either<NetworkCallError, Word>> getWordById(String wordId);
  Future<Either<NetworkCallError, Word>> updateWord({
    required String wordId,
    required String text,
    required String definition,
  });
  Future<Either<NetworkCallError, void>> deleteWord(String wordId);
  Future<Either<NetworkCallError, List<Word>>> getWordsByFolder(String folderId);
}
