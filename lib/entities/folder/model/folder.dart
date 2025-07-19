import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/model/language.dart';
import 'folder_type.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required String id,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required String name,
    required FolderType? type,
    required int wordCount,
    required Language? languageFrom,
    required Language? languageTo,
    required String? parentId,
    required List<Folder> subfolders,
  }) = _Folder;
}
