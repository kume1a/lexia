import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/field/email_field.dart';
import '../../../shared/ui/field/password_field.dart';
import '../../../shared/ui/loading_text_button.dart';
import '../../../shared/ui/logo_header.dart';
import '../state/sign_in_state.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return TapOutsideToClearFocus(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 52, 16, 12),
              child: BlocBuilder<SignInCubit, SignInState>(
                buildWhen: (previous, current) => previous.validateForm != current.validateForm,
                builder: (_, state) {
                  return ValidatedForm(
                    showErrors: state.validateForm,
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        const LogoHeaderMedium(),
                        const SizedBox(height: 8),
                        if (kDebugMode)
                          TextButton(
                            onPressed: context.signInCubit.onDevSignIn,
                            child: const Text('Dev SignIn'),
                          ),
                        const Spacer(),
                        EmailField(
                          onChanged: context.signInCubit.onEmailChanged,
                          validator: (_) =>
                              context.signInCubit.state.email.errToString((f) => f.translate(l)),
                        ),
                        const SizedBox(height: 16),
                        PasswordField(
                          onChanged: context.signInCubit.onPasswordChanged,
                          validator: (_) =>
                              context.signInCubit.state.password.errToString((f) => f.translate(l)),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: LoadingTextButton(
                            onPressed: context.signInCubit.onSubmit,
                            label: l.signIn,
                            isLoading: state.isSubmitting,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Spacer(flex: 3),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
