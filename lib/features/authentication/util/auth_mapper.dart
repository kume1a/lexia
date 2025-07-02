import 'package:injectable/injectable.dart';

import '../../../entities/user/util/user_mapper.dart';
import '../model/auth_payload.dart';
import '../model/token_payload_dto.dart';

@injectable
class AuthMapper {
  const AuthMapper(this._userMapper);

  final UserMapper _userMapper;

  AuthPayload tokenPayloadDtoToDomain(TokenPayloadDto dto) {
    return AuthPayload(accessToken: dto.accessToken, user: _userMapper.dtoToDomain(dto.user));
  }
}
