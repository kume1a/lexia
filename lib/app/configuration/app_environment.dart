import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

class AppEnvironment {
  AppEnvironment._();

  static const String _keyLocalApiUrl = 'LOCAL_API_URL';
  static const String _keyRemoteApiUrl = 'REMOTE_API_URL';

  static String _localApiUrl = '';
  static String _remoteApiUrl = '';

  static Future<void> load() async {
    if (kReleaseMode) {
      _localApiUrl = const String.fromEnvironment(_keyLocalApiUrl);
      _remoteApiUrl = const String.fromEnvironment(_keyRemoteApiUrl);

      if (_localApiUrl.isEmpty || _remoteApiUrl.isEmpty) {
        throw Exception('Missing environment variables');
      }

      return;
    }

    const environment = kDebugMode ? 'development' : 'production';

    const envFileName = './env/.env.$environment';

    Logger.root.info('Loading environment file: $envFileName');

    final localEnv = await _DotEnvLoader.load('./env/.env.local');

    if (localEnv.isNotEmpty) {
      Logger.root.info('Merging env with local $localEnv');
    }

    await dotenv.load(fileName: envFileName, mergeWith: localEnv);

    _localApiUrl = dotenv.get(_keyLocalApiUrl);
    _remoteApiUrl = dotenv.get(_keyRemoteApiUrl);
  }

  static String get localApiUrl => _localApiUrl;

  static String get remoteApiUrl => _remoteApiUrl;
}

class _DotEnvLoader {
  static Future<Map<String, String>> load(String filename) async {
    String? envString;

    try {
      envString = await rootBundle.loadString(filename);
    } catch (e) {
      Logger.root.warning('Failed to load $filename, $e');
    }

    if (envString == null || envString.isEmpty) {
      return {};
    }

    final fileLines = envString.split('\n');
    const dotEnvParser = Parser();

    return dotEnvParser.parse(fileLines);
  }
}
