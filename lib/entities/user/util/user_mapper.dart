import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/values/constant.dart';
import '../model/user.dart';
import '../model/user_dto.dart';

@injectable
class UserMapper {
  User dtoToDomain(UserDto dto) {
    return User(
      id: dto.id ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      username: dto.username ?? '',
      email: dto.email ?? '',
    );
  }
}
