import '../../entities/folder/model/folder.dart';
import '../../entities/word/model/word.dart';
import '../model/sort_order.dart';

class SortingUtils {
  static List<Folder> sortFolders(List<Folder> folders, SortOrder sortOrder) {
    final sortedFolders = List<Folder>.from(folders);

    switch (sortOrder) {
      case SortOrder.nameAsc:
        sortedFolders.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortOrder.nameDesc:
        sortedFolders.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case SortOrder.dateAsc:
        sortedFolders.sort((a, b) => _compareDatesAsc(a.createdAt, b.createdAt));
        break;
      case SortOrder.dateDesc:
        sortedFolders.sort((a, b) => _compareDatesDesc(a.createdAt, b.createdAt));
        break;
    }

    return sortedFolders;
  }

  static List<Word> sortWords(List<Word> words, SortOrder sortOrder) {
    final sortedWords = List<Word>.from(words);

    switch (sortOrder) {
      case SortOrder.nameAsc:
        sortedWords.sort((a, b) => a.text.toLowerCase().compareTo(b.text.toLowerCase()));
        break;
      case SortOrder.nameDesc:
        sortedWords.sort((a, b) => b.text.toLowerCase().compareTo(a.text.toLowerCase()));
        break;
      case SortOrder.dateAsc:
        sortedWords.sort((a, b) => _compareDatesAsc(a.createdAt, b.createdAt));
        break;
      case SortOrder.dateDesc:
        sortedWords.sort((a, b) => _compareDatesDesc(a.createdAt, b.createdAt));
        break;
    }

    return sortedWords;
  }

  static int _compareDatesAsc(DateTime? a, DateTime? b) {
    if (a == null && b == null) {
      return 0;
    }
    if (a == null) {
      return 1;
    }
    if (b == null) {
      return -1;
    }
    return a.compareTo(b);
  }

  static int _compareDatesDesc(DateTime? a, DateTime? b) {
    if (a == null && b == null) {
      return 0;
    }
    if (a == null) {
      return 1;
    }
    if (b == null) {
      return -1;
    }
    return b.compareTo(a);
  }
}
