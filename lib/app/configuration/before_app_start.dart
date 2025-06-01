import '../../shared/util/system_ui_manager.dart';
import '../di/register_dependencies.dart';
import 'configure_secure_storage.dart';

Future<void> beforeAppStart() async {
  final systemUiManager = getIt<SystemUiManager>();
  final configureSecureStorage = getIt<ConfigureSecureStorage>();

  await Future.wait([systemUiManager.lockPortraitOrientation(), configureSecureStorage()]);
}
