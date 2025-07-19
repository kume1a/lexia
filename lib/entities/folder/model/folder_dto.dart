import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/model/language.dart';
import 'folder_type.dart';

part 'folder_dto.freezed.dart';
part 'folder_dto.g.dart';

@freezed
class FolderDto with _$FolderDto {
  const factory FolderDto({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? name,
    FolderType? type,
    int? wordCount,
    Language? languageFrom,
    Language? languageTo,
    String? parentId,
    List<FolderDto>? subfolders,
  }) = _FolderDto;

  factory FolderDto.fromJson(Map<String, dynamic> json) => _$FolderDtoFromJson(json);
}
