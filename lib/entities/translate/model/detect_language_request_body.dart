import 'package:freezed_annotation/freezed_annotation.dart';

part 'detect_language_request_body.freezed.dart';
part 'detect_language_request_body.g.dart';

@freezed
class DetectLanguageRequestBody with _$DetectLanguageRequestBody {
  const factory DetectLanguageRequestBody({required String text}) = _DetectLanguageRequestBody;

  factory DetectLanguageRequestBody.fromJson(Map<String, dynamic> json) =>
      _$DetectLanguageRequestBodyFromJson(json);
}
