import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_word_body.g.dart';
part 'update_word_body.freezed.dart';

@freezed
class UpdateWordBody with _$UpdateWordBody {
  const factory UpdateWordBody({String? text, String? definition}) = _UpdateWordBody;

  factory UpdateWordBody.fromJson(Map<String, dynamic> json) => _$UpdateWordBodyFromJson(json);
}
