import 'package:freezed_annotation/freezed_annotation.dart';

import 'folder_path_item.dart';

part 'word_with_folder_path.freezed.dart';

@freezed
class WordWithFolderPath with _$WordWithFolderPath {
  const factory WordWithFolderPath({
    required String id,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required String text,
    required String definition,
    required List<FolderPathItem> folderPath,
  }) = _WordWithFolderPath;
}
