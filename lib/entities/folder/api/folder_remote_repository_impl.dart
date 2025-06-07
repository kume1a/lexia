import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

import '../model/folder.dart';
import 'folder_remote_repository.dart';

final fakeFolders = [
  Folder(id: '1', createdAt: DateTime.now(), updatedAt: DateTime.now(), name: 'Folder 1', wordCount: 0),
  Folder(id: '2', createdAt: DateTime.now(), updatedAt: DateTime.now(), name: 'Folder 2', wordCount: 1),
  Folder(id: '3', createdAt: DateTime.now(), updatedAt: DateTime.now(), name: 'Folder 3', wordCount: 2),
  Folder(id: '4', createdAt: DateTime.now(), updatedAt: DateTime.now(), name: 'Folder 4', wordCount: 3),
  Folder(id: '5', createdAt: DateTime.now(), updatedAt: DateTime.now(), name: 'Folder 5', wordCount: 4),
];

@LazySingleton(as: FolderRemoteRepository)
class FolderRemoteRepositoryImpl implements FolderRemoteRepository {
  @override
  Future<Either<NetworkCallError, Folder>> create({required String name}) {
    return Future.delayed(const Duration(seconds: 2), () {
      final newFolder = Folder(
        id: DateTime.now().toIso8601String(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        name: name,
        wordCount: 0,
      );
      fakeFolders.insert(0, newFolder);
      return right(newFolder);
    });
  }

  @override
  Future<Either<MutateEntityError, Folder>> updateById(String id, {required String name}) {
    return Future.delayed(const Duration(seconds: 2), () {
      final folderIndex = fakeFolders.indexWhere((folder) => folder.id == id);
      if (folderIndex == -1) {
        return left(MutateEntityError.notFound);
      }

      final updatedFolder = fakeFolders[folderIndex].copyWith(name: name, updatedAt: DateTime.now());
      fakeFolders[folderIndex] = updatedFolder;
      return right(updatedFolder);
    });
  }

  @override
  Future<Either<MutateEntityError, Folder>> deleteById(String id) {
    final folderIndex = fakeFolders.indexWhere((folder) => folder.id == id);
    if (folderIndex == -1) {
      return Future.error('Folder not found');
    }

    final removedOne = fakeFolders.removeAt(folderIndex);
    return Future.delayed(const Duration(seconds: 2), () => right(removedOne));
  }

  @override
  Future<Either<NetworkCallError, List<Folder>>> getAll() {
    return Future.delayed(const Duration(seconds: 2), () => right(fakeFolders));
  }

  @override
  Future<Either<GetEntityError, Folder>> getById(String id) {
    return Future.delayed(const Duration(seconds: 2), () {
      final folder = fakeFolders.firstWhereOrNull((folder) => folder.id == id);
      if (folder == null) {
        return left(GetEntityError.notFound);
      }

      return right(folder);
    });
  }
}
