import '../../../entities/folder/model/folder_type.dart';
import '../../../entities/folder/model/language.dart';
import '../app_localizations.dart';

extension FolderTypeIntlX on FolderType {
  String translate(AppLocalizations l) {
    return switch (this) {
      FolderType.wordCollection => l.wordCollection,
      FolderType.folderCollection => l.folderCollection,
    };
  }
}

extension LanguageIntlX on Language {
  String translate(AppLocalizations l) {
    return switch (this) {
      Language.english => l.english,
      Language.georgian => l.georgian,
    };
  }
}
