import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/api/api_client.dart';
import '../model/create_folder_body.dart';
import '../model/folder.dart';
import '../model/folder_type.dart';
import '../model/language.dart';
import '../model/move_folder_body.dart';
import '../model/update_folder_body.dart';
import '../util/folder_mapper.dart';
import 'folder_repository.dart';

@Injectable(as: FolderRepository)
class FolderRepositoryImpl with SafeHttpRequestWrap implements FolderRepository {
  FolderRepositoryImpl(this._apiClientProvider, this._folderMapper);

  final Provider<ApiClient> _apiClientProvider;
  final FolderMapper _folderMapper;

  @override
  Future<Either<NetworkCallError, List<Folder>>> getUserFolders() {
    return callCatchHandleNetworkCallError(() async {
      final folderDtos = await _apiClientProvider.get().getUserFolders();
      return folderDtos.map((dto) => _folderMapper.dtoToDomain(dto)).toList();
    });
  }

  @override
  Future<Either<NetworkCallError, List<Folder>>> getRootFolders() {
    return callCatchHandleNetworkCallError(() async {
      final folderDtos = await _apiClientProvider.get().getRootFolders();
      return folderDtos.map((dto) => _folderMapper.dtoToDomain(dto)).toList();
    });
  }

  @override
  Future<Either<NetworkCallError, Folder>> getById(String folderId) {
    return callCatchHandleNetworkCallError(() async {
      final folderDto = await _apiClientProvider.get().getFolderById(folderId);
      return _folderMapper.dtoToDomain(folderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, Folder>> create({
    required String name,
    required FolderType type,
    required Language? languageFrom,
    required Language? languageTo,
    required String? parentId,
  }) {
    return callCatchHandleNetworkCallError(() async {
      final body = CreateFolderBody(
        name: name,
        type: type,
        languageFrom: languageFrom,
        languageTo: languageTo,
        parentId: parentId,
      );
      final folderDto = await _apiClientProvider.get().createFolder(body);
      return _folderMapper.dtoToDomain(folderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, Folder>> updateById({required String folderId, required String name}) {
    return callCatchHandleNetworkCallError(() async {
      final body = UpdateFolderBody(name: name);
      final folderDto = await _apiClientProvider.get().updateFolderById(folderId, body);
      return _folderMapper.dtoToDomain(folderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, Folder>> moveById({required String folderId, String? parentId}) {
    return callCatchHandleNetworkCallError(() async {
      final body = MoveFolderBody(parentId: parentId);
      final folderDto = await _apiClientProvider.get().moveFolderById(folderId, body);
      return _folderMapper.dtoToDomain(folderDto);
    });
  }

  @override
  Future<Either<NetworkCallError, void>> deleteById(String folderId) {
    return callCatchHandleNetworkCallError(() async {
      await _apiClientProvider.get().deleteFolderById(folderId);
    });
  }
}
