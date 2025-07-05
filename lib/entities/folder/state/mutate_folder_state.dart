import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/intl/extension/error_intl.dart';
import '../../../app/navigation/page_navigator.dart';
import '../../../shared/typedefs.dart';
import '../../../shared/ui/bottom_sheet/bottom_sheet_manager.dart';
import '../../../shared/ui/bottom_sheet/select_option/select_option.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../api/folder_repository.dart';
import '../model/folder.dart';
import '../model/folder_type.dart';
import '../model/language.dart';

part 'mutate_folder_state.freezed.dart';

@freezed
class MutateFolderState with _$MutateFolderState {
  const factory MutateFolderState({
    required Name folderName,
    required FolderType folderType,
    Language? languageFrom,
    Language? languageTo,
    required bool validateForm,
    required bool isSubmitting,
  }) = _MutateFolderState;

  factory MutateFolderState.initial() => MutateFolderState(
    folderName: Name.empty(),
    folderType: FolderType.wordCollection,
    validateForm: false,
    isSubmitting: false,
  );
}

extension MutateFolderCubitX on BuildContext {
  MutateFolderCubit get mutateFolderCubit => read<MutateFolderCubit>();
}

@injectable
class MutateFolderCubit extends Cubit<MutateFolderState> {
  MutateFolderCubit(
    this._folderRepository,
    this._toastNotifier,
    this._pageNavigator,
    this._bottomSheetManager,
  ) : super(MutateFolderState.initial());

  final FolderRepository _folderRepository;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;
  final BottomSheetManager _bottomSheetManager;

  final nameFieldController = TextEditingController();

  Folder? _folder;

  void init({required Folder? folder}) {
    _folder = folder;

    if (_folder != null) {
      emit(
        state.copyWith(
          folderName: Name(_folder!.name),
          folderType: _folder!.type ?? state.folderType,
          languageFrom: _folder!.languageFrom,
          languageTo: _folder!.languageTo,
        ),
      );

      nameFieldController.text = _folder!.name;
    }
  }

  Future<void> onFolderTypePressed() async {
    final selectedType = await _bottomSheetManager.openOptionSelector<FolderType>(
      header: (l) => l.selectFolderType,
      options: [
        SelectOption(value: FolderType.wordCollection, label: (l) => l.wordCollection),
        SelectOption(value: FolderType.folderCollection, label: (l) => l.folderCollection),
      ],
    );

    if (selectedType == null) {
      return;
    }

    emit(state.copyWith(folderType: selectedType));
  }

  Future<void> onLanguageFromPressed() async {
    final selectedLanguage = await _openLanguageSelector(header: (l) => l.selectLanguageFrom);

    if (selectedLanguage == null) {
      return;
    }

    emit(state.copyWith(languageFrom: selectedLanguage));
  }

  Future<void> onLanguageToPressed() async {
    final selectedLanguage = await _openLanguageSelector(header: (l) => l.selectLanguageTo);

    if (selectedLanguage == null) {
      return;
    }

    emit(state.copyWith(languageTo: selectedLanguage));
  }

  void onNameChanged(String value) {
    emit(state.copyWith(folderName: Name(value)));
  }

  Future<void> onSubmit() async {
    emit(state.copyWith(validateForm: true));

    bool isValidationFailed = state.folderName.invalid;
    if (state.folderType == FolderType.wordCollection) {
      isValidationFailed = isValidationFailed || state.languageFrom == null || state.languageTo == null;
    }

    if (isValidationFailed) {
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    if (_folder == null) {
      await _folderRepository
          .create(
            name: state.folderName.getOrThrow,
            type: state.folderType,
            languageFrom: state.languageFrom,
            languageTo: state.languageTo,
            parentId: null,
          )
          .awaitFold((err) => _toastNotifier.error(description: (l) => err.translate(l)), (r) {
            _toastNotifier.success(description: (l) => l.folderCreatedSuccessfully);
            _pageNavigator.pop(result: r);
          });
    } else {
      await _folderRepository.updateById(folderId: _folder!.id, name: state.folderName.getOrThrow).awaitFold(
        (err) => _toastNotifier.error(description: (l) => err.translate(l)),
        (r) {
          _toastNotifier.success(description: (l) => l.folderUpdatedSuccessfully);
          _pageNavigator.pop(result: r);
        },
      );
    }

    emit(state.copyWith(isSubmitting: false));
  }

  Future<Language?> _openLanguageSelector({required LocalizedStringResolver header}) async {
    return await _bottomSheetManager.openOptionSelector<Language>(
      header: header,
      options: [
        SelectOption(value: Language.english, label: (l) => l.english),
        SelectOption(value: Language.georgian, label: (l) => l.georgian),
      ],
    );
  }
}
