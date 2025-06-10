import 'package:common_widgets/common_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../app/intl/extension/enum_intl.dart';
import '../../../app/intl/extension/error_intl.dart';
import '../../../entities/folder/model/language.dart';
import '../../../shared/ui/dropdown_container_field.dart';
import '../../../shared/ui/field/email_field.dart';
import '../../../shared/ui/field/password_field.dart';
import '../../../shared/ui/loading_text_button.dart';
import '../../../shared/ui/scrollable_form_wrapper.dart';
import '../state/sign_in_state.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return ScrollableFormWrapper(
      child: BlocBuilder<SignInCubit, SignInState>(
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
                  l.signIn,
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                if (kDebugMode)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: TextButton(
                      onPressed: context.signInCubit.onDevSignIn,
                      child: const Text('Dev SignIn'),
                    ),
                  ),
                EmailField(
                  controller: context.signInCubit.emailFieldController,
                  onChanged: context.signInCubit.onEmailChanged,
                  validator: (_) => context.signInCubit.state.email.errToString((f) => f.translate(l)),
                ),
                SizedBox(height: 12.h),
                SizedBox(height: 12.h),
                PasswordField(
                  controller: context.signInCubit.passwordFieldController,
                  onChanged: context.signInCubit.onPasswordChanged,
                  validator: (_) => context.signInCubit.state.password.errToString((f) => f.translate(l)),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: LoadingTextButton(
                    onPressed: context.signInCubit.onSubmit,
                    label: l.signIn,
                    isLoading: state.isSubmitting,
                  ),
                ),
                SizedBox(height: 12.h),
                Text("Don't have an account?"),
                GestureDetector(
                  onTap: context.signInCubit.onSignUpPressed,
                  child: Text(
                    l.signUp,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          );
        },
      ),
    );
  }
}
