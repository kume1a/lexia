import '../../../entities/folder/model/language.dart';
import '../app_localizations.dart';

extension LanguageIntlX on Language {
  String translate(AppLocalizations l) {
    return switch (this) {
      Language.english => l.english,
      Language.georgian => l.georgian,
    };
  }
}
