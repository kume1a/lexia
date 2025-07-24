import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder_path_item_dto.freezed.dart';
part 'folder_path_item_dto.g.dart';

@freezed
class FolderPathItemDto with _$FolderPathItemDto {
  const factory FolderPathItemDto({required String id, required String name}) = _FolderPathItemDto;

  factory FolderPathItemDto.fromJson(Map<String, dynamic> json) => _$FolderPathItemDtoFromJson(json);
}
