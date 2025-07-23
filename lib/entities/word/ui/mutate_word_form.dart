import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/loading_text_button.dart';
import '../state/mutate_word_state.dart';

class MutateWordForm extends StatelessWidget {
  const MutateWordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return BlocBuilder<MutateWordCubit, MutateWordState>(
      buildWhen: (previous, current) =>
          previous.validateForm != current.validateForm || previous.isSubmitting != current.isSubmitting,
      builder: (_, state) {
        return ValidatedForm(
          showErrors: state.validateForm,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FieldWordText(),
                SizedBox(height: 8.h),
                _FieldWordDefinition(),
                _TranslationSuggestions(),
                SizedBox(height: 12.h),
                LoadingTextButton(
                  isLoading: state.isSubmitting,
                  onPressed: context.mutateWordCubit.onSubmit,
                  label: l.submit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FieldWordText extends StatelessWidget {
  const _FieldWordText();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TextFormField(
      autofocus: true,
      controller: context.mutateWordCubit.textFieldController,
      autocorrect: false,
      decoration: InputDecoration(hintText: l.text),
      onChanged: context.mutateWordCubit.onTextChanged,
      validator: (_) => context.mutateWordCubit.state.text.errToString((err) => err.translate(l)),
    );
  }
}

class _FieldWordDefinition extends StatelessWidget {
  const _FieldWordDefinition();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TextFormField(
      controller: context.mutateWordCubit.definitionFieldController,
      autocorrect: false,
      decoration: InputDecoration(hintText: l.definition),
      onChanged: context.mutateWordCubit.onDefinitionChanged,
      validator: (_) => context.mutateWordCubit.state.definition.errToString((err) => err.translate(l)),
      minLines: 2,
      maxLines: 5,
    );
  }
}

class _TranslationSuggestions extends StatelessWidget {
  const _TranslationSuggestions();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    return BlocBuilder<MutateWordCubit, MutateWordState>(
      buildWhen: (previous, current) => previous.translationSuggestions != current.translationSuggestions,
      builder: (context, state) {
        return state.translationSuggestions.when(
          idle: () => SizedBox.shrink(),
          loading: () => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                SizedBox(width: 16.w, height: 16.w, child: CircularProgressIndicator(strokeWidth: 2)),
                SizedBox(width: 8.w),
                Text(
                  l.gettingTranslationSuggestions,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          failure: (_) => SizedBox.shrink(),
          success: (suggestions) {
            if (suggestions.isEmpty) {
              return SizedBox.shrink();
            }

            return Container(
              margin: EdgeInsets.only(top: 8.h),
              padding: EdgeInsets.only(left: 12.w, bottom: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.translationSuggestions,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        icon: Icon(Icons.refresh, size: 16.w),
                        onPressed: context.mutateWordCubit.onReloadTranslationSuggestions,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Wrap(
                      spacing: 8.w,
                      runSpacing: 4.h,
                      children: suggestions.map((suggestion) {
                        return InkWell(
                          onTap: () =>
                              context.mutateWordCubit.onTranslationSuggestionSelected(suggestion.text),
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: theme.colorScheme.primary.withValues(alpha: 0.1),
                              border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              suggestion.text,
                              style: TextStyle(fontSize: 13.sp, color: theme.colorScheme.primary),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
