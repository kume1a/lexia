import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_dto.g.dart';
part 'error_response_dto.freezed.dart';

@freezed
class ErrorResponseDto with _$ErrorResponseDto {
  const factory ErrorResponseDto({
    required String error,
    required String message,
    int? statusCode,
    Map<String, dynamic>? details,
  }) = _ErrorResponseDto;

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) => _$ErrorResponseDtoFromJson(json);
}
