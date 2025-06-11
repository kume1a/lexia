import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../shared/cubit/entity_loader_cubit.dart';
import '../api/word_remote_repository.dart';
import '../model/word.dart';

typedef FolderWordListState = DataState<NetworkCallError, List<Word>>;

extension FolderWordListCubitX on BuildContext {
  FolderWordListCubit get folderWordListCubit => read<FolderWordListCubit>();
}

@injectable
final class FolderWordListCubit extends EntityWithErrorCubit<NetworkCallError, List<Word>> {
  FolderWordListCubit(this._wordRemoteRepository);

  final WordRemoteRepository _wordRemoteRepository;

  String? _folderId;

  void init({required String folderId}) {
    _folderId = folderId;

    loadEntityAndEmit();
  }

  void onCreateWordPressed() {}

  @override
  Future<Either<NetworkCallError, List<Word>>> loadEntity() async {
    if (_folderId == null) {
      Logger.root.severe('Folder ID is null, cannot load words.');
      return left(NetworkCallError.unknown);
    }

    return _wordRemoteRepository.getAllByFolderId(_folderId!);
  }
}
