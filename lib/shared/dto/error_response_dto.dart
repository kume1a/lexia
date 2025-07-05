import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_dto.freezed.dart';
part 'error_response_dto.g.dart';

@freezed
class ErrorResponseDto with _$ErrorResponseDto {
  const factory ErrorResponseDto({
    String? error,
    String? message,
    int? statusCode,
    Map<String, dynamic>? details,
  }) = _ErrorResponseDto;

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) => _$ErrorResponseDtoFromJson(json);
}
