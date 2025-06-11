import 'package:common_models/common_models.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../app/navigation/page_navigator.dart';
import '../../../pages/mutate_word_page.dart';
import '../../../shared/cubit/entity_loader_cubit.dart';
import '../../../shared/ui/bottom_sheet/bottom_sheet_manager.dart';
import '../../../shared/ui/bottom_sheet/select_option/select_option.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../../../shared/values/assets.dart';
import '../api/word_remote_repository.dart';
import '../model/word.dart';

typedef FolderWordListState = DataState<NetworkCallError, List<Word>>;

extension FolderWordListCubitX on BuildContext {
  FolderWordListCubit get folderWordListCubit => read<FolderWordListCubit>();
}

@injectable
final class FolderWordListCubit extends EntityWithErrorCubit<NetworkCallError, List<Word>> {
  FolderWordListCubit(
    this._wordRemoteRepository,
    this._pageNavigator,
    this._bottomSheetManager,
    this._toastNotifier,
  );

  final WordRemoteRepository _wordRemoteRepository;
  final PageNavigator _pageNavigator;
  final BottomSheetManager _bottomSheetManager;
  final ToastNotifier _toastNotifier;

  String? _folderId;

  void init({required String folderId}) {
    _folderId = folderId;

    loadEntityAndEmit();
  }

  @override
  Future<Either<NetworkCallError, List<Word>>> loadEntity() async {
    if (_folderId == null) {
      Logger.root.severe('Folder ID is null, cannot load words.');
      return left(NetworkCallError.unknown);
    }

    return _wordRemoteRepository.getAllByFolderId(_folderId!);
  }

  Future<void> onNewWordPressed() async {
    if (_folderId == null) {
      Logger.root.severe('Folder ID is null, cannot create a new word.');
      return;
    }

    final args = MutateWordPageArgs(folderId: _folderId!, wordId: null);

    final newWord = await _pageNavigator.toMutateWord(args);

    if (newWord == null) {
      return;
    }

    emit(state.map((words) => [newWord, ...words]));
  }

  Future<void> onWordMenuPressed(Word word) async {
    if (_folderId == null) {
      Logger.root.severe('Folder ID is null, cannot perform actions on word.');
      return;
    }

    final selectedOption = await _bottomSheetManager.openOptionSelector(
      header: (l) => l.wordAndText(word.text),
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
        final args = MutateWordPageArgs(folderId: _folderId!, wordId: word.id);
        final updatedWord = await _pageNavigator.toMutateWord(args);

        if (updatedWord == null) {
          return;
        }

        emit(state.map((words) => words.replace((e) => e.id == updatedWord.id, (_) => updatedWord)));
      case 1:
        return _wordRemoteRepository
            .deleteById(word.id)
            .awaitFold(
              (l) {
                _toastNotifier.error(description: (l) => l.wordDeleteError);
              },
              (r) {
                _toastNotifier.success(description: (l) => l.wordDeletedSuccessfully);
                emit(state.map((folders) => folders.where((e) => e.id != word.id).toList()));
              },
            );
    }
  }
}
