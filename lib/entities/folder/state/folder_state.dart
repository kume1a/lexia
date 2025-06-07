import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../shared/cubit/entity_loader_cubit.dart';
import '../api/folder_remote_repository.dart';
import '../model/folder.dart';

typedef FolderState = DataState<GetEntityError, Folder>;

extension FolderCubitX on BuildContext {
  FolderCubit get folderCubit => read<FolderCubit>();
}

@injectable
final class FolderCubit extends EntityWithErrorCubit<GetEntityError, Folder> {
  FolderCubit(this._folderRemoteRepository);

  final FolderRemoteRepository _folderRemoteRepository;

  String? _folderId;

  void init({required String folderId}) {
    _folderId = folderId;
    loadEntityAndEmit();
  }

  @override
  Future<Either<GetEntityError, Folder>> loadEntity() async {
    if (_folderId == null) {
      Logger.root.warning('Folder ID is not set. Cannot load folder.');
      return left(GetEntityError.unknown);
    }

    return _folderRemoteRepository.getById(_folderId!);
  }
}
