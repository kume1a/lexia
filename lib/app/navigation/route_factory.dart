import 'package:flutter/material.dart';
import '../../pages/folder_page.dart';
import '../../pages/main/main_page.dart';
import '../../pages/mutate_word_page.dart';
import '../../pages/profile_page.dart';
import '../../pages/settings_page.dart';
import '../../pages/sign_in_page.dart';
import '../../pages/sign_up_page.dart';
import '../../pages/welcome_page.dart';

import 'routes.dart';

Route<dynamic> routeFactory(RouteSettings settings) {
  return switch (settings.name) {
    Routes.root => _createWelcomeRoute(settings),
    Routes.welcome => _createWelcomeRoute(settings),
    Routes.signIn => _createSignInRoute(settings),
    Routes.signUp => _createSignUpRoute(settings),
    Routes.main => _createMainRoute(settings),
    Routes.profile => _createProfileRoute(settings),
    Routes.settings => _createSettingsRoute(settings),
    Routes.folder => _createFolderRoute(settings),
    Routes.mutateWord => _createMutateWordRoute(settings),
    _ => throw Exception('route $settings is not supported'),
  };
}

Route _createWelcomeRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const WelcomePage(), settings: settings);
}

Route _createSignInRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const SignInPage(), settings: settings);
}

Route _createSignUpRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const SignUpPage(), settings: settings);
}

Route _createMainRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const MainPage(), settings: settings);
}

Route _createProfileRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const ProfilePage(), settings: settings);
}

Route _createSettingsRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => const SettingsPage(), settings: settings);
}

Route _createFolderRoute(RouteSettings settings) {
  final args = _getArgs<FolderPageArgs>(settings);

  return MaterialPageRoute(
    builder: (_) => FolderPage(args: args),
    settings: settings,
  );
}

Route _createMutateWordRoute(RouteSettings settings) {
  final args = _getArgs<MutateWordPageArgs>(settings);

  return MaterialPageRoute(
    builder: (_) => MutateWordPage(args: args),
    settings: settings,
  );
}

T _getArgs<T>(RouteSettings settings) {
  if (settings.arguments == null || settings.arguments is! T) {
    throw Exception('Arguments typeof ${T.runtimeType} is required');
  }

  return settings.arguments as T;
}
