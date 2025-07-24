import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import '../model/word_with_folder_path.dart';
import '../ui/word_duplicate_dialog.dart';

@lazySingleton
class WordPopups {
  Future<bool> showWordDuplicateDialog(WordWithFolderPath duplicateWord) async {
    final result = await GlobalNavigator.dialog(
      WordDuplicateDialog(duplicateWord: duplicateWord),
      barrierDismissible: false,
    );

    if (result == null || result is! bool) {
      return false;
    }

    return result;
  }
}
