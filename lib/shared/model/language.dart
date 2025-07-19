import 'package:common_utilities/common_utilities.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

enum Language {
  @JsonValue('ENGLISH')
  english,

  @JsonValue('GEORGIAN')
  georgian,
}

@lazySingleton
final class LanguageMapper extends EnumMapper<Language, String> {
  @override
  Map<String, Language> values = {'ENGLISH': Language.english, 'GEORGIAN': Language.georgian};
}
