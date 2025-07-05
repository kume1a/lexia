import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../entities/user/util/user_mapper.dart';
import '../model/auth_payload.dart';
import '../model/token_payload_dto.dart';

@injectable
class AuthMapper {
  const AuthMapper(this._userMapper);

  final UserMapper _userMapper;

  AuthPayload tokenPayloadDtoToDomain(TokenPayloadDto dto) {
    return AuthPayload(accessToken: dto.accessToken ?? '', user: tryMap(dto.user, _userMapper.dtoToDomain));
  }
}
