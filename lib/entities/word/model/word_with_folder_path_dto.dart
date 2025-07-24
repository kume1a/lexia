import 'package:freezed_annotation/freezed_annotation.dart';

import 'folder_path_item_dto.dart';

part 'word_with_folder_path_dto.freezed.dart';
part 'word_with_folder_path_dto.g.dart';

@freezed
class WordWithFolderPathDto with _$WordWithFolderPathDto {
  const factory WordWithFolderPathDto({
    required String id,
    required String createdAt,
    required String updatedAt,
    required String text,
    required String definition,
    required List<FolderPathItemDto> folderPath,
  }) = _WordWithFolderPathDto;

  factory WordWithFolderPathDto.fromJson(Map<String, dynamic> json) => _$WordWithFolderPathDtoFromJson(json);
}
