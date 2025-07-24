import 'package:freezed_annotation/freezed_annotation.dart';

import 'word_with_folder_path.dart';

part 'word_duplicate_check.freezed.dart';

@freezed
class WordDuplicateCheck with _$WordDuplicateCheck {
  const factory WordDuplicateCheck({required bool isDuplicate, WordWithFolderPath? word}) =
      _WordDuplicateCheck;
}
