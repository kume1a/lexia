import 'package:freezed_annotation/freezed_annotation.dart';

enum FolderType {
  @JsonValue('FOLDER_COLLECTION')
  folderCollection,
  @JsonValue('WORD_COLLECTION')
  wordCollection,
}
