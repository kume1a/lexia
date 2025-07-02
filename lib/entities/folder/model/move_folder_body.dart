import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_folder_body.g.dart';
part 'move_folder_body.freezed.dart';

@freezed
class MoveFolderBody with _$MoveFolderBody {
  const factory MoveFolderBody({String? parentId}) = _MoveFolderBody;

  factory MoveFolderBody.fromJson(Map<String, dynamic> json) => _$MoveFolderBodyFromJson(json);
}
