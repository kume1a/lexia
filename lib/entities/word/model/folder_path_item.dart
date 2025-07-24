import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder_path_item.freezed.dart';

@freezed
class FolderPathItem with _$FolderPathItem {
  const factory FolderPathItem({required String id, required String name}) = _FolderPathItem;
}
