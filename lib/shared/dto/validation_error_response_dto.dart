import 'package:freezed_annotation/freezed_annotation.dart';
import 'validation_error_dto.dart';

part 'validation_error_response_dto.g.dart';
part 'validation_error_response_dto.freezed.dart';

@freezed
class ValidationErrorResponseDto with _$ValidationErrorResponseDto {
  const factory ValidationErrorResponseDto({
    required String message,
    required List<ValidationErrorDto> errors,
  }) = _ValidationErrorResponseDto;

  factory ValidationErrorResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorResponseDtoFromJson(json);
}
