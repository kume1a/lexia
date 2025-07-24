import '../../../entities/folder/model/folder_type.dart';
import '../../../shared/model/language.dart';
import '../../../shared/model/sort_order.dart';
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

extension SortOrderIntlX on SortOrder {
  String translate(AppLocalizations l) {
    return switch (this) {
      SortOrder.nameAsc => l.sortOrderNameAsc,
      SortOrder.nameDesc => l.sortOrderNameDesc,
      SortOrder.dateAsc => l.sortOrderDateAsc,
      SortOrder.dateDesc => l.sortOrderDateDesc,
    };
  }
}
