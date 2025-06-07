import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import '../model/folder.dart';
import '../ui/mutate_folder_dialog.dart';

@lazySingleton
class FolderDialogs {
  Future<Folder?> showMutateFolderDialog({Folder? folder}) {
    return GlobalNavigator.dialog(MutateFolderDialog(folder: folder));
  }
}
