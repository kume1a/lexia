import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_dto.freezed.dart';
part 'word_dto.g.dart';

@freezed
class WordDto with _$WordDto {
  const factory WordDto({
    String? id,
    String? createdAt,
    String? updatedAt,
    String? text,
    String? definition,
    String? folderId,
  }) = _WordDto;

  factory WordDto.fromJson(Map<String, dynamic> json) => _$WordDtoFromJson(json);
}
