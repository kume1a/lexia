import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../pages/folder_page.dart';
import '../../../shared/cubit/entity_loader_cubit.dart';
import '../../../shared/ui/bottom_sheet/bottom_sheet_manager.dart';
import '../../../shared/ui/bottom_sheet/select_option/select_option.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../../../shared/values/assets.dart';
import '../api/folder_repository.dart';
import '../model/folder.dart';
import '../util/folder_dialogs.dart';

typedef FolderListState = SimpleDataState<List<Folder>>;

extension FolderListCubitX on BuildContext {
  FolderListCubit get folderListCubit => read<FolderListCubit>();
}

@injectable
final class FolderListCubit extends EntityLoaderCubit<List<Folder>> {
  FolderListCubit(
    this._folderRepository,
    this._folderDialogs,
    this._bottomSheetManager,
    this._toastNotifier,
    this._pageNavigator,
  ) {
    loadEntityAndEmit();
  }

  final FolderRepository _folderRepository;
  final FolderDialogs _folderDialogs;
  final BottomSheetManager _bottomSheetManager;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;

  @override
  Future<List<Folder>?> loadEntity() async {
    final res = await _folderRepository.getUserFolders();

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
        final updatedFolder = await _folderDialogs.showMutateFolderDialog(folder: folder);

        if (updatedFolder == null) {
          return;
        }

        emit(state.map((folders) => folders.replace((e) => e.id == updatedFolder.id, (_) => updatedFolder)));
      case 1:
        return _folderRepository
            .deleteById(folder.id)
            .awaitFold(
              (l) {
                _toastNotifier.error(description: (l) => l.folderDeleteError(folder.name));
              },
              (r) {
                _toastNotifier.success(description: (l) => l.folderDeleted(folder.name));
                emit(state.map((folders) => folders.where((e) => e.id != folder.id).toList()));
              },
            );
    }
  }

  Future<void> onCreateFolderPressed() async {
    final createdFolder = await _folderDialogs.showMutateFolderDialog();

    if (createdFolder == null) {
      return;
    }

    emit(state.map((folders) => [...folders, createdFolder]));
  }

  void onFolderPressed(Folder folder) {
    final args = FolderPageArgs(folderId: folder.id);

    _pageNavigator.toFolder(args);
  }
}
