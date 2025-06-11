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
