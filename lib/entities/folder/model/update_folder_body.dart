import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_folder_body.g.dart';
part 'update_folder_body.freezed.dart';

@freezed
class UpdateFolderBody with _$UpdateFolderBody {
  const factory UpdateFolderBody({String? name, String? parentId}) = _UpdateFolderBody;

  factory UpdateFolderBody.fromJson(Map<String, dynamic> json) => _$UpdateFolderBodyFromJson(json);
}
