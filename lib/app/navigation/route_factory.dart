import 'package:flutter/material.dart';
import '../../pages/welcome_page.dart';

import 'routes.dart';

Route<dynamic> routeFactory(RouteSettings settings) {
  return switch (settings.name) {
    Routes.root => _createWelcomeRoute(settings),
    Routes.welcome => _createWelcomeRoute(settings),
    _ => throw Exception('route $settings is not supported'),
  };
}

Route _createWelcomeRoute(RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => WelcomePage(), settings: settings);
}

// T _getArgs<T>(RouteSettings settings) {
//   if (settings.arguments == null || settings.arguments is! T) {
//     throw Exception('Arguments typeof ${T.runtimeType} is required');
//   }

//   return settings.arguments as T;
// }
