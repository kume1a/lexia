import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_with_folder_dto.freezed.dart';
part 'word_with_folder_dto.g.dart';

@freezed
class WordFolderInfo with _$WordFolderInfo {
  const factory WordFolderInfo({String? id, String? name}) = _WordFolderInfo;

  factory WordFolderInfo.fromJson(Map<String, dynamic> json) => _$WordFolderInfoFromJson(json);
}

@freezed
class WordWithFolderDto with _$WordWithFolderDto {
  const factory WordWithFolderDto({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? text,
    String? definition,
    WordFolderInfo? folder,
  }) = _WordWithFolderDto;

  factory WordWithFolderDto.fromJson(Map<String, dynamic> json) => _$WordWithFolderDtoFromJson(json);
}
