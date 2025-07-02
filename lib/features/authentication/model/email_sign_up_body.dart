// filepath: /Users/toko/dev/projects/lexia/lexiabackend/client/dart/lib/module/auth/model/email_sign_up_body.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_sign_up_body.g.dart';
part 'email_sign_up_body.freezed.dart';

@freezed
class EmailSignUpBody with _$EmailSignUpBody {
  const factory EmailSignUpBody({required String username, required String email, required String password}) =
      _EmailSignUpBody;

  factory EmailSignUpBody.fromJson(Map<String, dynamic> json) => _$EmailSignUpBodyFromJson(json);
}
