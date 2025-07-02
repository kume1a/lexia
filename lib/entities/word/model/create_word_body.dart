import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_word_body.g.dart';
part 'create_word_body.freezed.dart';

@freezed
class CreateWordBody with _$CreateWordBody {
  const factory CreateWordBody({required String text, required String definition, required String folderId}) =
      _CreateWordBody;

  factory CreateWordBody.fromJson(Map<String, dynamic> json) => _$CreateWordBodyFromJson(json);
}
