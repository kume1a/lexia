import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error_dto.g.dart';
part 'validation_error_dto.freezed.dart';

@freezed
class ValidationErrorDto with _$ValidationErrorDto {
  const factory ValidationErrorDto({required String field, required String message, dynamic value}) =
      _ValidationErrorDto;

  factory ValidationErrorDto.fromJson(Map<String, dynamic> json) => _$ValidationErrorDtoFromJson(json);
}
