import 'package:flutter/widgets.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../entities/word/model/word.dart';
import '../../pages/folder_page.dart';
import '../../pages/mutate_word_page.dart';
import 'routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

@lazySingleton
class PageNavigator {
  void pop<T>({T? result}) => GlobalNavigator.maybePop(result: result);

  Future<void> toWelcome() => GlobalNavigator.pushNamedAndRemoveAll(Routes.welcome);

  Future<void> toSignIn() => GlobalNavigator.pushNamedAndRemoveAll(Routes.signIn);

  Future<void> toSignUp() => GlobalNavigator.pushNamed(Routes.signUp);

  Future<void> toMain() => GlobalNavigator.pushNamedAndRemoveAll(Routes.main);

  Future<void> toProfile() => GlobalNavigator.pushNamed(Routes.profile);

  Future<void> toSettings() => GlobalNavigator.pushNamed(Routes.settings);

  Future<void> toFolder(FolderPageArgs args) => GlobalNavigator.pushNamed(Routes.folder, arguments: args);

  Future<Word?> toMutateWord(MutateWordPageArgs args) async {
    final res = await GlobalNavigator.pushNamed(Routes.mutateWord, arguments: args);

    if (res is Word) {
      return res;
    } else {
      Logger.root.warning('Expected Word type, but got ${res.runtimeType}');
      return null;
    }
  }
}
