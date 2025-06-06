import 'package:common_models/common_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import 'app/app.dart';
import 'app/configuration/app_environment.dart';
import 'app/configuration/before_app_start.dart';
import 'app/configuration/configure_logging.dart';
import 'app/configuration/global_http_overrides.dart';
import 'app/di/register_dependencies.dart';
import 'app/navigation/page_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppEnvironment.load();

  await registerDependencies(kDebugMode ? Environment.dev : Environment.prod);
  GlobalNavigator.navigatorKey = navigatorKey;

  GlobalHttpOverrides.configure();

  VVOConfig.password.minLength = 6;

  configureLogging();

  await beforeAppStart();

  runApp(const App());
}
