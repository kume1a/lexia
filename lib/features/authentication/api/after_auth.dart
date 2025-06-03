import '../model/auth_payload.dart';

abstract interface class AfterAuth {
  Future<void> call({required AuthPayload payload});
}
