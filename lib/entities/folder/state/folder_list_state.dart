import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../features/user_preferences/api/user_preference_store.dart';
import '../../../pages/folder_page.dart';
import '../../../shared/cubit/entity_loader_cubit.dart';
import '../../../shared/model/sort_order.dart';
import '../../../shared/ui/bottom_sheet/bottom_sheet_manager.dart';
import '../../../shared/ui/bottom_sheet/select_option/select_option.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../../../shared/util/sortable_helper.dart';
import '../../../shared/util/sorting_utils.dart';
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
    this._userPreferenceStore,
  ) {
    loadEntityAndEmit();
  }

  final FolderRepository _folderRepository;
  final FolderDialogs _folderDialogs;
  final BottomSheetManager _bottomSheetManager;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;
  final UserPreferenceStore _userPreferenceStore;

  SortOrder _currentSortOrder = SortOrder.nameAsc;

  @override
  Future<List<Folder>?> loadEntity() async {
    _currentSortOrder = await SortableHelper.loadSortOrder(_userPreferenceStore, isFolder: true);

    final res = await _folderRepository.getRootFolders();
    final folders = res.rightOrNull;

    if (folders == null) {
      return null;
    }

    return SortingUtils.sortFolders(folders, _currentSortOrder);
  }

  Future<void> onSortPressed() async {
    final selectedOption = await SortableHelper.showSortOptions(
      bottomSheetManager: _bottomSheetManager,
      currentSortOrder: _currentSortOrder,
      getHeaderText: (l) => l.sortFoldersBy,
    );

    if (selectedOption == null || _currentSortOrder == selectedOption) {
      return;
    }

    _currentSortOrder = selectedOption;
    await SortableHelper.saveSortOrder(_userPreferenceStore, selectedOption, isFolder: true);

    emit(state.map((folders) => SortingUtils.sortFolders(folders, _currentSortOrder)));
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
        final updatedFolder = await _folderDialogs.showMutateFolderDialog(
          folderId: folder.id,
          parentFolderId: null,
        );

        if (updatedFolder == null) {
          return;
        }

        emit(
          state.map((folders) {
            final updatedFolders = folders.replace((e) => e.id == updatedFolder.id, (_) => updatedFolder);
            return SortingUtils.sortFolders(updatedFolders, _currentSortOrder);
          }),
        );
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
    final createdFolder = await _folderDialogs.showMutateFolderDialog(folderId: null, parentFolderId: null);

    if (createdFolder == null) {
      return;
    }

    emit(state.map((folders) => SortingUtils.sortFolders([...folders, createdFolder], _currentSortOrder)));
  }

  void onFolderPressed(Folder folder) {
    final args = FolderPageArgs(folderId: folder.id);

    _pageNavigator.toFolder(args);
  }
}
