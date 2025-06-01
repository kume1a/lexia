import 'package:common_models/common_models.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../app/configuration/app_environment.dart';

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
  SignInCubit() : super(SignInState.initial());

  void onEmailChanged(String email) {
    emit(state.copyWith(email: Email(email)));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: Password(password)));
  }

  Future<void> onSubmit() async {
    emit(state.copyWith(isSubmitting: true, validateForm: true));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isSubmitting: false, validateForm: false));
  }

  void onDevSignIn() {
    emit(
      state.copyWith(
        email: Email(AppEnvironment.devSignInEmail),
        password: Password(AppEnvironment.devSignInPassword),
      ),
    );
  }
}
