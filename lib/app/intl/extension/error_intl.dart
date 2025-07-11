import 'package:common_models/common_models.dart';

import '../../../features/authentication/model/email_sign_up_error.dart';
import '../../../features/authentication/model/sign_in_error.dart';
import '../app_localizations.dart';

extension NetworkCallErrorIntl on NetworkCallError {
  String translate(AppLocalizations l) {
    return when(
      unknown: () => l.unknownError,
      network: () => l.noInternetConnection,
      internalServer: () => l.internalServerError,
    );
  }
}

extension MutateEntityErrorIntl on MutateEntityError {
  String translate(AppLocalizations l) {
    return when(
      network: () => l.noInternetConnection,
      unknown: () => l.unknownError,
      notFound: () => l.entityNotFound,
    );
  }
}

extension GetEntityErrorIntl on GetEntityError {
  String translate(AppLocalizations l) {
    return when(
      network: () => l.noInternetConnection,
      unknown: () => l.unknownError,
      notFound: () => l.entityNotFound,
    );
  }
}

extension NameErrorIntl on NameError {
  String translate(AppLocalizations l) {
    return when(
      empty: () => l.fieldIsRequired,
      tooLong: () => l.nameIsTooLong,
      tooShort: () => l.nameIsTooShort,
    );
  }
}

extension EmailErrorIntl on EmailError {
  String translate(AppLocalizations l) {
    return when(
      empty: () => l.fieldIsRequired,
      tooLong: () => l.emailIsTooLong,
      containsWhitespace: () => l.emailContainsWhitespace,
      invalid: () => l.emailIsInvalid,
    );
  }
}

extension PasswordErrorIntl on PasswordError {
  String translate(AppLocalizations l) {
    return maybeWhen(
      orElse: () => '',
      empty: () => l.fieldIsRequired,
      tooLong: () => l.passwordIsTooShort,
      tooShort: () => l.passwordIsTooShort,
      containsWhitespace: () => l.passwordContainsWhitespace,
    );
  }
}

extension RepeatPasswordErrorIntl on RepeatedPasswordError {
  String translate(AppLocalizations l) {
    return maybeWhen(
      orElse: () => '',
      empty: () => l.fieldIsRequired,
      doesNotMatch: () => l.passwordsDoNotMatch,
    );
  }
}

extension SignInErrorIntl on SignInError {
  String translate(AppLocalizations l) {
    return when(
      unknown: () => l.unknownError,
      network: () => l.noInternetConnection,
      invalidEmailOrPassword: () => l.invalidEmailOrPassword,
    );
  }
}

extension EmailSignUpErrorIntl on EmailSignUpError {
  String translate(AppLocalizations l) {
    return when(
      emailAlreadyInUse: () => l.emailAlreadyInUse,
      unknown: () => l.unknownError,
      network: () => l.noInternetConnection,
    );
  }
}

extension RequiredStringErrorIntl on RequiredStringError {
  String translate(AppLocalizations l) {
    return when(empty: () => l.fieldIsRequired, tooLong: () => l.stringIsTooLong);
  }
}
