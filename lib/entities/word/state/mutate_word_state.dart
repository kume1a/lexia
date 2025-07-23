import 'dart:async';

import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../app/intl/extension/error_intl.dart';
import '../../../app/navigation/page_navigator.dart';
import '../../../shared/model/language.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../../folder/api/folder_repository.dart';
import '../../folder/model/folder.dart';
import '../../translate/model/translation_variant.dart';
import '../../translate/service/translate_service.dart';
import '../api/word_repository.dart';

part 'mutate_word_state.freezed.dart';

@freezed
class MutateWordState with _$MutateWordState {
  const factory MutateWordState({
    required RequiredString text,
    required RequiredString definition,
    required bool validateForm,
    required bool isSubmitting,
    required SimpleDataState<Folder> folder,
    required SimpleDataState<List<TranslationVariant>> translationSuggestions,
  }) = _MutateWordState;

  factory MutateWordState.initial() => MutateWordState(
    text: RequiredString.empty(),
    definition: RequiredString.empty(),
    validateForm: false,
    isSubmitting: false,
    folder: SimpleDataState.idle(),
    translationSuggestions: SimpleDataState.idle(),
  );
}

extension MutateWordCubitX on BuildContext {
  MutateWordCubit get mutateWordCubit => read<MutateWordCubit>();
}

@injectable
class MutateWordCubit extends Cubit<MutateWordState> {
  MutateWordCubit(
    this._wordRepository,
    this._toastNotifier,
    this._pageNavigator,
    this._translateService,
    this._folderRepository,
  ) : super(MutateWordState.initial());

  final WordRepository _wordRepository;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;
  final TranslateService _translateService;
  final FolderRepository _folderRepository;

  final textFieldController = TextEditingController();
  final definitionFieldController = TextEditingController();

  String? _folderId;
  String? _wordId;
  Timer? _translationDebounceTimer;

  @override
  Future<void> close() {
    _translationDebounceTimer?.cancel();
    textFieldController.dispose();
    definitionFieldController.dispose();
    return super.close();
  }

  void init({required String folderId, required String? wordId}) {
    _folderId = folderId;
    _wordId = wordId;

    _loadFolder();

    if (_wordId != null) {
      _loadInitialWord();
    }
  }

  Future<void> _loadFolder() async {
    emit(state.copyWith(folder: SimpleDataState.loading()));

    final folderResult = await _folderRepository.getById(_folderId!);

    folderResult.fold(
      (error) {
        emit(state.copyWith(folder: SimpleDataState.failure()));
        _toastNotifier.error(description: (l) => error.translate(l));
      },
      (folder) {
        emit(state.copyWith(folder: SimpleDataState.success(folder)));
      },
    );
  }

  void onTextChanged(String text) {
    emit(state.copyWith(text: RequiredString(text)));

    _translationDebounceTimer?.cancel();

    if (text.trim().isEmpty) {
      emit(state.copyWith(translationSuggestions: SimpleDataState.idle()));
    } else {
      _translationDebounceTimer = Timer(
        Duration(milliseconds: 200),
        () => _fetchTranslationSuggestions(text.trim()),
      );
    }
  }

  void onDefinitionChanged(String definition) {
    emit(state.copyWith(definition: RequiredString(definition)));
  }

  void onTranslationSuggestionSelected(String suggestion) {
    definitionFieldController.text = suggestion;
    emit(
      state.copyWith(definition: RequiredString(suggestion), translationSuggestions: SimpleDataState.idle()),
    );
  }

  Future<void> _fetchTranslationSuggestions(String text) async {
    final folder = state.folder.getOrNull;
    if (folder?.languageFrom == null || folder?.languageTo == null) {
      Logger.root.warning('Folder languages are not set, cannot fetch translation suggestions');
      return;
    }

    emit(state.copyWith(translationSuggestions: SimpleDataState.loading()));

    try {
      await _performTranslation(text, folder!.languageFrom!, folder.languageTo!);
    } catch (e) {
      Logger.root.warning('Translation error: $e');
      emit(state.copyWith(translationSuggestions: SimpleDataState.failure()));
    }
  }

  Future<void> _performTranslation(String text, Language from, Language to) async {
    final result = await _translateService.translateText(text: text, languageFrom: from, languageTo: to);

    result.fold(
      (error) {
        Logger.root.warning('Translation failed: $error');
        emit(state.copyWith(translationSuggestions: SimpleDataState.failure()));
      },
      (translationResult) {
        emit(state.copyWith(translationSuggestions: SimpleDataState.success(translationResult.translations)));
      },
    );
  }

  Future<void> onSubmit() async {
    if (_folderId == null) {}

    emit(state.copyWith(validateForm: true));

    if (state.text.invalid || state.definition.invalid) {
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    if (_wordId == null) {
      await _wordRepository
          .create(text: state.text.getOrThrow, definition: state.definition.getOrThrow, folderId: _folderId!)
          .awaitFold((err) => _toastNotifier.error(description: (l) => err.translate(l)), (r) {
            _toastNotifier.success(description: (l) => l.wordCreatedSuccessfully);

            _resetForm();
          });
    } else {
      await _wordRepository
          .updateById(wordId: _wordId!, text: state.text.getOrThrow, definition: state.definition.getOrThrow)
          .awaitFold((err) => _toastNotifier.error(description: (l) => err.translate(l)), (r) {
            _toastNotifier.success(description: (l) => l.wordUpdatedSuccessfully);
            _pageNavigator.pop(result: r);
          });
    }

    emit(state.copyWith(isSubmitting: false));
  }

  Future<void> _loadInitialWord() async {
    if (_wordId == null) {
      Logger.root.warning(
        'MutateWordCubit: _loadInitialWord called with null _wordId. This should not happen.',
      );
      return;
    }

    return _wordRepository.getWordById(_wordId!).awaitFold(
      (err) => _toastNotifier.error(description: (l) => err.translate(l)),
      (word) {
        textFieldController.text = word.text;
        definitionFieldController.text = word.definition;

        emit(state.copyWith(text: RequiredString(word.text), definition: RequiredString(word.definition)));
      },
    );
  }

  void _resetForm() {
    emit(
      state.copyWith(
        definition: RequiredString(''),
        text: RequiredString(''),
        validateForm: false,
        translationSuggestions: SimpleDataState.idle(),
      ),
    );

    textFieldController.clear();
    definitionFieldController.clear();
  }
}
