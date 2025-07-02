import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_with_folder_dto.g.dart';
part 'word_with_folder_dto.freezed.dart';

@freezed
class WordFolderInfo with _$WordFolderInfo {
  const factory WordFolderInfo({required String id, required String name}) = _WordFolderInfo;

  factory WordFolderInfo.fromJson(Map<String, dynamic> json) => _$WordFolderInfoFromJson(json);
}

@freezed
class WordWithFolderDto with _$WordWithFolderDto {
  const factory WordWithFolderDto({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String text,
    required String definition,
    required WordFolderInfo folder,
  }) = _WordWithFolderDto;

  factory WordWithFolderDto.fromJson(Map<String, dynamic> json) => _$WordWithFolderDtoFromJson(json);
}
