import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../app/intl/extension/error_intl.dart';
import '../../../app/navigation/page_navigator.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../api/word_repository.dart';

part 'mutate_word_state.freezed.dart';

@freezed
class MutateWordState with _$MutateWordState {
  const factory MutateWordState({
    required RequiredString text,
    required RequiredString definition,
    required bool validateForm,
    required bool isSubmitting,
  }) = _MutateWordState;

  factory MutateWordState.initial() => MutateWordState(
    text: RequiredString.empty(),
    definition: RequiredString.empty(),
    validateForm: false,
    isSubmitting: false,
  );
}

extension MutateWordCubitX on BuildContext {
  MutateWordCubit get mutateWordCubit => read<MutateWordCubit>();
}

@injectable
class MutateWordCubit extends Cubit<MutateWordState> {
  MutateWordCubit(this._wordRepository, this._toastNotifier, this._pageNavigator)
    : super(MutateWordState.initial());

  final WordRepository _wordRepository;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;

  final textFieldController = TextEditingController();
  final definitionFieldController = TextEditingController();

  String? _folderId;
  String? _wordId;

  void init({required String folderId, required String? wordId}) {
    _folderId = folderId;
    _wordId = wordId;

    if (_wordId != null) {
      _loadInitialWord();
    }
  }

  void onTextChanged(String text) {
    emit(state.copyWith(text: RequiredString(text)));
  }

  void onDefinitionChanged(String definition) {
    emit(state.copyWith(definition: RequiredString(definition)));
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
            _pageNavigator.pop(result: r);
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
}
