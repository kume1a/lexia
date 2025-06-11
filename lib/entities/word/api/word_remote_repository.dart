import 'package:common_models/common_models.dart';

import '../model/word.dart';

abstract interface class WordRemoteRepository {
  Future<Either<NetworkCallError, Word>> create({
    required String folderId,
    required String text,
    required String definition,
  });

  Future<Either<MutateEntityError, Word>> updateById(
    String id, {
    required String folderId,
    required String text,
    required String definition,
  });

  Future<Either<MutateEntityError, Word>> deleteById(String id);

  Future<Either<NetworkCallError, List<Word>>> getAllByFolderId(String folderId);

  Future<Either<GetEntityError, Word>> getById(String id);
}
