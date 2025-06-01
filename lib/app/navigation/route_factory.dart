import 'package:flutter/material.dart';
import '../../pages/main_page.dart';
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
    _ => throw Exception('route $settings is not supported'),
  };
}

Route _createWelcomeRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => WelcomePage(), settings: settings);
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

// T _getArgs<T>(RouteSettings settings) {
//   if (settings.arguments == null || settings.arguments is! T) {
//     throw Exception('Arguments typeof ${T.runtimeType} is required');
//   }

//   return settings.arguments as T;
// }
