import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void configureLogging() {
  Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}: ${record.time}: ${record.message}');
  });
}
