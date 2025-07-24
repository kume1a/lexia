import 'package:freezed_annotation/freezed_annotation.dart';

import 'word_with_folder_path_dto.dart';

part 'word_duplicate_check_dto.freezed.dart';
part 'word_duplicate_check_dto.g.dart';

@freezed
class WordDuplicateCheckDto with _$WordDuplicateCheckDto {
  const factory WordDuplicateCheckDto({required bool isDuplicate, WordWithFolderPathDto? word}) =
      _WordDuplicateCheckDto;

  factory WordDuplicateCheckDto.fromJson(Map<String, dynamic> json) => _$WordDuplicateCheckDtoFromJson(json);
}
