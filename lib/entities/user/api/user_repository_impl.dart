import 'package:common_models/common_models.dart';
import 'package:common_network_components/common_network_components.dart';
import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/api/api_client.dart';
import '../model/update_user_body.dart';
import '../model/user.dart';
import '../util/user_mapper.dart';
import 'user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl with SafeHttpRequestWrap implements UserRepository {
  UserRepositoryImpl(this._apiClientProvider, this._userMapper);

  final Provider<ApiClient> _apiClientProvider;
  final UserMapper _userMapper;

  @override
  Future<Either<NetworkCallError, User>> getAuthUser() {
    return callCatchHandleNetworkCallError(() async {
      final userDto = await _apiClientProvider.get().getAuthUser();
      return _userMapper.dtoToDomain(userDto);
    });
  }

  @override
  Future<Either<NetworkCallError, User>> updateAuthUser({required String username}) {
    return callCatchHandleNetworkCallError(() async {
      final body = UpdateUserBody(username: username);
      final userDto = await _apiClientProvider.get().updateAuthUser(body);
      return _userMapper.dtoToDomain(userDto);
    });
  }
}
