import 'package:injectable/injectable.dart';

import '../model/user.dart';
import '../model/user_dto.dart';

@injectable
class UserMapper {
  User dtoToDomain(UserDto dto) {
    return User(id: dto.id, createdAt: dto.createdAt, username: dto.username, email: dto.email);
  }

  UserDto domainToDto(User domain) {
    return UserDto(
      id: domain.id,
      createdAt: domain.createdAt ?? DateTime.now(),
      username: domain.username ?? '',
      email: domain.email,
    );
  }
}
