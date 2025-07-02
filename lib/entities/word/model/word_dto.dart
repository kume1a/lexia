import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_dto.g.dart';
part 'word_dto.freezed.dart';

@freezed
class WordDto with _$WordDto {
  const factory WordDto({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String text,
    required String definition,
    required String folderId,
  }) = _WordDto;

  factory WordDto.fromJson(Map<String, dynamic> json) => _$WordDtoFromJson(json);
}
