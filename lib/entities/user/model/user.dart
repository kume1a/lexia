import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required DateTime? createdAt,
    required String? username,
    required String email,
  }) = _User;
}
