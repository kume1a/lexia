import 'package:freezed_annotation/freezed_annotation.dart';
import 'folder_type.dart';
import 'language.dart';

part 'folder_dto.g.dart';
part 'folder_dto.freezed.dart';

@freezed
class FolderDto with _$FolderDto {
  const factory FolderDto({
    required String id,
    required String name,
    required FolderType type,
    required int wordCount,
    Language? languageFrom,
    Language? languageTo,
    String? parentId,
    required String createdAt,
    required String updatedAt,
    List<FolderDto>? subfolders,
    required bool hasWords,
  }) = _FolderDto;

  factory FolderDto.fromJson(Map<String, dynamic> json) => _$FolderDtoFromJson(json);
}
