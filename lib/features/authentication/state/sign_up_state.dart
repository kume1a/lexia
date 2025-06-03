import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../../app/configuration/app_environment.dart';
import '../../../app/navigation/page_navigator.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required Name username,
    required Email email,
    required Password password,
    required RepeatedPassword repeatedPassword,
    required bool isSubmitting,
    required bool validateForm,
  }) = _SignUpState;

  factory SignUpState.initial() => SignUpState(
    username: Name.empty(),
    email: Email.empty(),
    password: Password.empty(),
    repeatedPassword: RepeatedPassword.empty(),
    isSubmitting: false,
    validateForm: false,
  );
}

extension SignUpCubitX on BuildContext {
  SignUpCubit get signUpCubit => read<SignUpCubit>();
}

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._pageNavigator) : super(SignUpState.initial());

  final PageNavigator _pageNavigator;

  final usernameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final repeatedPasswordFieldController = TextEditingController();

  String _repeatedPasswordValue = '';

  void onUsernameChanged(String value) {
    emit(state.copyWith(username: Name(value)));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: Email(email)));
  }

  void onPasswordChanged(String password) => emit(
    state.copyWith(
      password: Password(password),
      repeatedPassword: RepeatedPassword(password, _repeatedPasswordValue),
    ),
  );

  void onRepeatedPasswordChanged(String repeatedPassword) {
    _repeatedPasswordValue = repeatedPassword;
    emit(state.copyWith(repeatedPassword: RepeatedPassword(state.password.get ?? '', repeatedPassword)));
  }

  Future<void> onSubmit() async {
    emit(state.copyWith(validateForm: true));

    Logger.root.info(
      'form is valid: '
      '${!state.email.invalid && !state.username.invalid && !state.password.invalid && !state.repeatedPassword.invalid}',
    );

    if (state.email.invalid ||
        state.username.invalid ||
        state.password.invalid ||
        state.repeatedPassword.invalid) {
      return;
    }

    Logger.root.info('SignUpCubit.onSubmit() - form is valid');

    emit(state.copyWith(isSubmitting: true));

    Logger.root.info('emitting isSubmitting: true');

    await Future.delayed(const Duration(seconds: 2));

    Logger.root.info('emitting isSubmitting: false');

    emit(state.copyWith(isSubmitting: false));

    // emit(state.copyWith(isSubmitting: true));
    // final result = await _authService.signUp(
    //   username: state.username.getOrThrow,
    //   email: state.email.getOrThrow,
    //   password: state.password.getOrThrow,
    // );
    // emit(state.copyWith(isSubmitting: false));

    // result.fold(_failureNotifierPool.signUp.notify, (_) async {
    //   await _afterSignUp();

    //   _pageNavigator.toConfirmAccountEmailPage();
    // });
  }

  Future<void> onDevSignUp() async {
    final username = AppEnvironment.devSignInUsername;
    final email = AppEnvironment.devSignInEmail;
    final password = AppEnvironment.devSignInPassword;

    emit(
      state.copyWith(
        username: Name(username),
        email: Email(email),
        password: Password(password),
        repeatedPassword: RepeatedPassword(password, password),
      ),
    );

    usernameFieldController.text = username;
    emailFieldController.text = email;
    passwordFieldController.text = password;
    repeatedPasswordFieldController.text = password;

    return onSubmit();
  }

  void onSignInPressed() {
    _pageNavigator.pop();
  }
}
