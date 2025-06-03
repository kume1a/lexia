import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../shared/ui/field/email_field.dart';
import '../../../shared/ui/field/password_field.dart';
import '../../../shared/ui/field/repeat_password_field.dart';
import '../../../shared/ui/field/username_field.dart';
import '../../../shared/ui/loading_text_button.dart';
import '../../../shared/ui/scrollable_form_wrapper.dart';
import '../state/sign_up_state.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return ScrollableFormWrapper(
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.validateForm != current.validateForm || previous.isSubmitting != current.isSubmitting,
        builder: (_, state) {
          return ValidatedForm(
            showErrors: state.validateForm,
            child: Column(
              children: [
                const Spacer(flex: 2),
                SizedBox(height: 8.h),
                Text(
                  l.signUp,
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                if (kDebugMode)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: TextButton(
                      onPressed: context.signUpCubit.onDevSignUp,
                      child: const Text('Dev SignUp'),
                    ),
                  ),
                UsernameField(
                  controller: context.signUpCubit.usernameFieldController,
                  onChanged: context.signUpCubit.onUsernameChanged,
                  validator: (_) => context.signUpCubit.state.username.errToString((f) => f.translate(l)),
                ),
                SizedBox(height: 12.h),
                EmailField(
                  controller: context.signUpCubit.emailFieldController,
                  onChanged: context.signUpCubit.onEmailChanged,
                  validator: (_) => context.signUpCubit.state.email.errToString((f) => f.translate(l)),
                ),
                SizedBox(height: 12.h),
                PasswordField(
                  controller: context.signUpCubit.passwordFieldController,
                  onChanged: context.signUpCubit.onPasswordChanged,
                  validator: (_) => context.signUpCubit.state.password.errToString((f) => f.translate(l)),
                ),
                SizedBox(height: 12.h),
                RepeatPasswordField(
                  controller: context.signUpCubit.repeatedPasswordFieldController,
                  onChanged: context.signUpCubit.onRepeatedPasswordChanged,
                  validator: (_) =>
                      context.signUpCubit.state.repeatedPassword.errToString((f) => f.translate(l)),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: LoadingTextButton(
                    onPressed: context.signUpCubit.onSubmit,
                    label: l.signUp,
                    isLoading: state.isSubmitting,
                  ),
                ),
                SizedBox(height: 12.h),
                const Spacer(flex: 3),
              ],
            ),
          );
        },
      ),
    );
  }
}
