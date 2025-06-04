import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../shared/cubit/entity_loader_cubit.dart';
import '../api/folder_remote_repository.dart';
import '../model/folder.dart';
import '../util/folder_dialogs.dart';

typedef FolderListState = SimpleDataState<List<Folder>>;

extension FolderListCubitX on BuildContext {
  FolderListCubit get folderListCubit => read<FolderListCubit>();
}

@injectable
final class FolderListCubit extends EntityLoaderCubit<List<Folder>> {
  FolderListCubit(this._folderRemoteRepository, this._folderDialogs) {
    loadEntityAndEmit();
  }

  final FolderRemoteRepository _folderRemoteRepository;
  final FolderDialogs _folderDialogs;

  @override
  Future<List<Folder>?> loadEntity() async {
    final res = await _folderRemoteRepository.getAll();

    Logger.root.info('Folder list loaded with items: ${res.rightOrNull}');

    return res.rightOrNull;
  }

  void onFolderPressed(Folder folder) {}

  Future<void> onCreateFolderPressed() async {
    await _folderDialogs.showMutateFolderDialog();

    loadEntityAndEmit();
  }
}
