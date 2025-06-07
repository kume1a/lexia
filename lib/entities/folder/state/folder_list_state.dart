import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../shared/cubit/entity_loader_cubit.dart';
import '../../../shared/ui/bottom_sheet/bottom_sheet_manager.dart';
import '../../../shared/ui/bottom_sheet/select_option/select_option.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../../../shared/values/assets.dart';
import '../api/folder_remote_repository.dart';
import '../model/folder.dart';
import '../util/folder_dialogs.dart';

typedef FolderListState = SimpleDataState<List<Folder>>;

extension FolderListCubitX on BuildContext {
  FolderListCubit get folderListCubit => read<FolderListCubit>();
}

@injectable
final class FolderListCubit extends EntityLoaderCubit<List<Folder>> {
  FolderListCubit(
    this._folderRemoteRepository,
    this._folderDialogs,
    this._bottomSheetManager,
    this._toastNotifier,
  ) {
    loadEntityAndEmit();
  }

  final FolderRemoteRepository _folderRemoteRepository;
  final FolderDialogs _folderDialogs;
  final BottomSheetManager _bottomSheetManager;
  final ToastNotifier _toastNotifier;

  @override
  Future<List<Folder>?> loadEntity() async {
    final res = await _folderRemoteRepository.getAll();

    Logger.root.info('Folder list loaded with items: ${res.rightOrNull}');

    return res.rightOrNull;
  }

  Future<void> onFolderMenuPressed(Folder folder) async {
    final selectedOption = await _bottomSheetManager.openOptionSelector(
      header: (l) => l.folderAndName(folder.name),
      options: [
        SelectOption(value: 0, label: (l) => l.edit, iconAssetName: Assets.svgPencil),
        SelectOption(value: 1, label: (l) => l.delete, iconAssetName: Assets.svgTrashCan),
      ],
    );

    if (selectedOption == null) {
      return;
    }

    switch (selectedOption) {
      case 0:
        return _folderDialogs.showMutateFolderDialog(folder: folder);
      case 1:
        return _folderRemoteRepository.deleteById(folder.id).awaitFold((l) {
          _toastNotifier.error(description: (l) => l.folderDeleteError(folder.name));
        }, (r) {});
    }
  }

  Future<void> onCreateFolderPressed() async {
    await _folderDialogs.showMutateFolderDialog();

    loadEntityAndEmit();
  }

  void onFolderPressed(Folder folder) {}
}
