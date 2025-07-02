import 'package:common_models/common_models.dart';

import '../model/user.dart';

abstract class UserRepository {
  Future<Either<NetworkCallError, User>> getAuthUser();
  Future<Either<NetworkCallError, User>> updateAuthUser({required String username});
}
