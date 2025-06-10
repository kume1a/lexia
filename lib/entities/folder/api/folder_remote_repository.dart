import 'package:common_models/common_models.dart';

import '../model/folder.dart';
import '../model/language.dart';

abstract interface class FolderRemoteRepository {
  Future<Either<NetworkCallError, Folder>> create({
    required String name,
    required Language languageFrom,
    required Language languageTo,
  });

  Future<Either<MutateEntityError, Folder>> updateById(
    String id, {
    required String name,
    required Language languageFrom,
    required Language languageTo,
  });

  Future<Either<MutateEntityError, Folder>> deleteById(String id);

  Future<Either<NetworkCallError, List<Folder>>> getAll();

  Future<Either<GetEntityError, Folder>> getById(String id);
}
