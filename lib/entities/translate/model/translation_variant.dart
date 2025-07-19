import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_variant.freezed.dart';

@freezed
class TranslationVariant with _$TranslationVariant {
  const factory TranslationVariant({required String text, required double confidence}) = _TranslationVariant;
}
