import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

class AppEnvironment {
  AppEnvironment._();

  static const String _keyLocalApiUrl = 'LOCAL_API_URL';
  static const String _keyRemoteApiUrl = 'REMOTE_API_URL';
  static const String _keyDevSignInEmail = 'DEV_SIGN_IN_EMAIL';
  static const String _keyDevSignInPassword = 'DEV_SIGN_IN_PASSWORD';
  static const String _keyDevSignInUsername = 'DEV_SIGN_IN_USERNAME';

  static String _localApiUrl = '';
  static String _remoteApiUrl = '';
  static String _devSignInEmail = '';
  static String _devSignInPassword = '';
  static String _devSignInUsername = '';

  static Future<void> load() async {
    if (kReleaseMode) {
      _localApiUrl = const String.fromEnvironment(_keyLocalApiUrl);
      _remoteApiUrl = const String.fromEnvironment(_keyRemoteApiUrl);
      _devSignInEmail = const String.fromEnvironment(_keyDevSignInEmail);
      _devSignInPassword = const String.fromEnvironment(_keyDevSignInPassword);
      _devSignInUsername = const String.fromEnvironment(_keyDevSignInUsername);

      if (_localApiUrl.isEmpty ||
          _remoteApiUrl.isEmpty ||
          _devSignInEmail.isEmpty ||
          _devSignInPassword.isEmpty ||
          _devSignInUsername.isEmpty) {
        throw Exception(
          'Missing environment variables'
          '$_keyLocalApiUrl: $_localApiUrl, '
          '$_keyRemoteApiUrl: $_remoteApiUrl, '
          '$_keyDevSignInEmail: $_devSignInEmail, '
          '$_keyDevSignInPassword: $_devSignInPassword'
          '$_keyDevSignInUsername: $_devSignInUsername',
        );
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
    _devSignInEmail = dotenv.get(_keyDevSignInEmail, fallback: '');
    _devSignInPassword = dotenv.get(_keyDevSignInPassword, fallback: '');
    _devSignInUsername = dotenv.get(_keyDevSignInUsername, fallback: '');
  }

  static String get localApiUrl => _localApiUrl;

  static String get remoteApiUrl => _remoteApiUrl;

  static String get devSignInEmail => _devSignInEmail;

  static String get devSignInPassword => _devSignInPassword;

  static String get devSignInUsername => _devSignInUsername;
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
