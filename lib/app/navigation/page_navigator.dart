import 'package:flutter/widgets.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import 'routes.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

@lazySingleton
class PageNavigator {
  void pop<T>({T? result}) => GlobalNavigator.maybePop(result: result);

  void toWelcome() => GlobalNavigator.pushNamedAndRemoveAll(Routes.welcome);

  void toSignIn() => GlobalNavigator.pushNamedAndRemoveAll(Routes.signIn);

  void toSignUp() => GlobalNavigator.pushNamed(Routes.signUp);

  void toMain() => GlobalNavigator.pushNamedAndRemoveAll(Routes.main);
}
