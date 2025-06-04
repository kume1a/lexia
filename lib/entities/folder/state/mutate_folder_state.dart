import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/intl/extension/error_intl.dart';
import '../../../app/navigation/page_navigator.dart';
import '../../../shared/ui/toast_notifier.dart';
import '../api/folder_remote_repository.dart';
import '../model/folder.dart';

part 'mutate_folder_state.freezed.dart';

@freezed
class MutateFolderState with _$MutateFolderState {
  const factory MutateFolderState({
    required Name folderName,
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
  MutateFolderCubit(this._folderRemoteRepository, this._toastNotifier, this._pageNavigator)
    : super(MutateFolderState.initial());

  final FolderRemoteRepository _folderRemoteRepository;
  final ToastNotifier _toastNotifier;
  final PageNavigator _pageNavigator;

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

  Future<void> onSubmit() async {
    emit(state.copyWith(validateForm: true));

    if (state.folderName.invalid) {
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    if (_folder == null) {
      await _folderRemoteRepository.create(name: state.folderName.getOrThrow).awaitFold(
        (err) => _toastNotifier.error(description: (l) => err.translate(l)),
        (r) {
          _toastNotifier.success(description: (l) => l.folderCreatedSuccessfully);
          _pageNavigator.pop(result: r);
        },
      );
    } else {
      await _folderRemoteRepository.updateById(_folder!.id, name: state.folderName.getOrThrow).awaitFold(
        (err) => _toastNotifier.error(description: (l) => err.translate(l)),
        (r) {
          _toastNotifier.success(description: (l) => l.folderUpdatedSuccessfully);
          _pageNavigator.pop(result: r);
        },
      );
    }

    emit(state.copyWith(isSubmitting: false));
  }
}
