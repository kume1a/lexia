import 'package:freezed_annotation/freezed_annotation.dart';

part 'translate_request_body.freezed.dart';
part 'translate_request_body.g.dart';

@freezed
class TranslateRequestBody with _$TranslateRequestBody {
  const factory TranslateRequestBody({
    required String text,
    required String languageFrom,
    required String languageTo,
  }) = _TranslateRequestBody;

  factory TranslateRequestBody.fromJson(Map<String, dynamic> json) => _$TranslateRequestBodyFromJson(json);
}
