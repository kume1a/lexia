import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DiStorageModule {
  @lazySingleton
  FlutterSecureStorage flutterSecureStorage() {
    return const FlutterSecureStorage();
  }

  @lazySingleton
  @preResolve
  Future<SharedPreferences> sharedPreferences() {
    return SharedPreferences.getInstance();
  }
}
