import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/model/language.dart';
import 'folder_type.dart';

part 'create_folder_body.freezed.dart';
part 'create_folder_body.g.dart';

@freezed
class CreateFolderBody with _$CreateFolderBody {
  const factory CreateFolderBody({
    required String name,
    required FolderType type,
    Language? languageFrom,
    Language? languageTo,
    String? parentId,
  }) = _CreateFolderBody;

  factory CreateFolderBody.fromJson(Map<String, dynamic> json) => _$CreateFolderBodyFromJson(json);
}
