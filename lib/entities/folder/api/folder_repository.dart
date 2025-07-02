import 'package:common_models/common_models.dart';

import '../model/folder.dart';
import '../model/folder_type.dart';
import '../model/language.dart';

abstract class FolderRepository {
  Future<Either<NetworkCallError, List<Folder>>> getUserFolders();
  Future<Either<NetworkCallError, List<Folder>>> getRootFolders();
  Future<Either<NetworkCallError, Folder>> getFolderById(String folderId);
  Future<Either<NetworkCallError, Folder>> createFolder({
    required String name,
    required FolderType type,
    required Language languageFrom,
    required Language languageTo,
    String? parentId,
  });
  Future<Either<NetworkCallError, Folder>> updateFolder({required String folderId, required String name});
  Future<Either<NetworkCallError, Folder>> moveFolder({required String folderId, String? parentId});
  Future<Either<NetworkCallError, void>> deleteFolder(String folderId);
}
