import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/configuration/app_environment.dart';
import '../../../app/navigation/page_navigator.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    required Email email,
    required Password password,
    required bool isSubmitting,
    required bool validateForm,
  }) = _SignInState;

  factory SignInState.initial() =>
      SignInState(email: Email.empty(), password: Password.empty(), isSubmitting: false, validateForm: false);
}

extension SignInCubitX on BuildContext {
  SignInCubit get signInCubit => read<SignInCubit>();
}

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._pageNavigator) : super(SignInState.initial());

  final PageNavigator _pageNavigator;

  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();

  void onEmailChanged(String email) {
    emit(state.copyWith(email: Email(email)));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: Password(password)));
  }

  Future<void> onSubmit() async {
    emit(state.copyWith(validateForm: true));

    if (state.email.invalid || state.password.invalid) {
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isSubmitting: false));
  }

  Future<void> onDevSignIn() async {
    final email = AppEnvironment.devSignInEmail;
    final password = AppEnvironment.devSignInPassword;

    emit(state.copyWith(email: Email(email), password: Password(password)));

    emailFieldController.text = email;
    passwordFieldController.text = password;

    return onSubmit();
  }

  void onSignUpPressed() {
    _pageNavigator.toSignUp();
  }
}
