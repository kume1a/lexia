import 'package:common_models/common_models.dart';

import '../model/folder.dart';

abstract interface class FolderRemoteRepository {
  Future<Either<NetworkCallError, Folder>> create({required String name});

  Future<Either<MutateEntityError, Folder>> updateById(String id, {required String name});

  Future<Either<MutateEntityError, Folder>> deleteById(String id);

  Future<Either<NetworkCallError, List<Folder>>> getAll();
}
