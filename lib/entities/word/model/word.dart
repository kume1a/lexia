import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';

@freezed
class Word with _$Word {
  const factory Word({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String text,
    required String definition,
  }) = _Word;
}
