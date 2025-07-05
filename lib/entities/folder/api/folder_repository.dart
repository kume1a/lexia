import 'package:common_models/common_models.dart';

import '../model/folder.dart';
import '../model/folder_type.dart';
import '../model/language.dart';

abstract class FolderRepository {
  Future<Either<NetworkCallError, List<Folder>>> getUserFolders();
  Future<Either<NetworkCallError, List<Folder>>> getRootFolders();
  Future<Either<NetworkCallError, Folder>> getById(String folderId);
  Future<Either<NetworkCallError, List<Folder>>> getSubfoldersByFolderId(String folderId);
  Future<Either<NetworkCallError, Folder>> create({
    required String name,
    required FolderType type,
    required Language? languageFrom,
    required Language? languageTo,
    required String? parentId,
  });
  Future<Either<NetworkCallError, Folder>> updateById({required String folderId, required String name});
  Future<Either<NetworkCallError, Folder>> moveById({required String folderId, String? parentId});
  Future<Either<NetworkCallError, void>> deleteById(String folderId);
}
