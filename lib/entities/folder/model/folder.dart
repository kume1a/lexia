import 'package:freezed_annotation/freezed_annotation.dart';

import 'language.dart';

part 'folder.freezed.dart';

@freezed
class Folder with _$Folder {
  const factory Folder({
    required String id,
    required DateTime? createdAt,
    required DateTime? updatedAt,
    required String name,
    required int wordCount,
    required Language languageFrom,
    required Language languageTo,
  }) = _Folder;
}
