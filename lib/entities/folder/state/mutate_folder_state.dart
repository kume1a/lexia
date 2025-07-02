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
import '../api/folder_remote_repository.dart';
import '../model/folder.dart';
import '../model/language.dart';

part 'mutate_folder_state.freezed.dart';

@freezed
class MutateFolderState with _$MutateFolderState {
  const factory MutateFolderState({
    required Name folderName,
    Language? languageFrom,
    Language? languageTo,
    required bool validateForm,
    required bool isSubmitting,
  }) = _MutateFolderState;

  factory MutateFolderState.initial() =>
      MutateFolderState(folderName: Name.empty(), validateForm: false, isSubmitting: false);
}

extension MutateFolderCubitX on BuildContext {
  MutateFolderCubit get mutateFolderCubit => read<MutateFolderCubit>();
}

@injectable
class MutateFolderCubit extends Cubit<MutateFolderState> {
  MutateFolderCubit(
    this._folderRemoteRepository,
    this._toastNotifier,
    this._pageNavigator,
    this._bottomSheetManager,
  ) : super(MutateFolderState.initial());

  final FolderRemoteRepository _folderRemoteRepository;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;
  final BottomSheetManager _bottomSheetManager;

  final nameFieldController = TextEditingController();

  Folder? _folder;

  void init({required Folder? folder}) {
    _folder = folder;

    if (_folder != null) {
      emit(state.copyWith(folderName: Name(_folder!.name)));

      nameFieldController.text = _folder!.name;
    }
  }

  void onNameChanged(String value) {
    emit(state.copyWith(folderName: Name(value)));
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

  Future<void> onSubmit() async {
    emit(state.copyWith(validateForm: true));

    if (state.folderName.invalid || state.languageFrom == null || state.languageTo == null) {
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    if (_folder == null) {
      await _folderRemoteRepository
          .create(
            name: state.folderName.getOrThrow,
            languageFrom: state.languageFrom!,
            languageTo: state.languageTo!,
          )
          .awaitFold((err) => _toastNotifier.error(description: (l) => err.translate(l)), (r) {
            _toastNotifier.success(description: (l) => l.folderCreatedSuccessfully);
            _pageNavigator.pop(result: r);
          });
    } else {
      await _folderRemoteRepository
          .updateById(
            _folder!.id,
            name: state.folderName.getOrThrow,
            languageFrom: state.languageFrom!,
            languageTo: state.languageTo!,
          )
          .awaitFold((err) => _toastNotifier.error(description: (l) => err.translate(l)), (r) {
            _toastNotifier.success(description: (l) => l.folderUpdatedSuccessfully);
            _pageNavigator.pop(result: r);
          });
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
