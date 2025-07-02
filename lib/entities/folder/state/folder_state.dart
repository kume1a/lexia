import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../shared/cubit/entity_loader_cubit.dart';
import '../api/folder_repository.dart';
import '../model/folder.dart';

typedef FolderState = DataState<NetworkCallError, Folder>;

extension FolderCubitX on BuildContext {
  FolderCubit get folderCubit => read<FolderCubit>();
}

@injectable
final class FolderCubit extends EntityWithErrorCubit<NetworkCallError, Folder> {
  FolderCubit(this._folderRepository);

  final FolderRepository _folderRepository;

  String? _folderId;

  void init({required String folderId}) {
    _folderId = folderId;
    loadEntityAndEmit();
  }

  @override
  Future<Either<NetworkCallError, Folder>> loadEntity() async {
    if (_folderId == null) {
      Logger.root.warning('Folder ID is not set. Cannot load folder.');
      return left(NetworkCallError.unknown);
    }

    return _folderRepository.getFolderById(_folderId!);
  }
}
