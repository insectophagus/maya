part of 'wizard_bloc.dart';

final class WizardState extends Equatable {
  const WizardState({
    this.step = 1,
    this.password = '',
    this.resetPassword = '',
    this.tokenName = '',
    this.email = '',
    this.passphrase = '',
    this.isComplete = false
  });

  final int step;
  final String password;
  final String resetPassword;
  final String passphrase;
  final String tokenName;
  final String email;
  final bool isComplete;


  WizardState copyWith({
    int Function()? step,
    String Function()? password,
    String Function()? resetPassword,
    String Function()? passphrase,
    String Function()? tokenName,
    String Function()? email,
    bool Function()? isComplete
  }) {
    return WizardState(
      step: step != null ? step() : this.step,
      password: password != null ? password() : this.password,
      resetPassword: resetPassword != null ? resetPassword() : this.resetPassword,
      passphrase: passphrase != null ? passphrase() : this.passphrase,
      tokenName: tokenName != null ? tokenName() : this.tokenName,
      email: email != null ? email() : this.email,
      isComplete: isComplete != null ? isComplete() : this.isComplete,
    );
  }

  @override
  List<Object?> get props => [
        step,
        password,
        resetPassword,
        passphrase,
      ];
}

class ErrorState extends Equatable {
  const ErrorState({
    this.passwordError,
    this.resetPassworError,
    this.tokenNameError,
    this.passphraseError,
    this.emailError
  });

  final String? passwordError;
  final String? resetPassworError;
  final String? passphraseError;
  final String? tokenNameError;
  final String? emailError;

  bool get isValid {
    return passwordError == null && resetPassworError == null && passphraseError == null && tokenNameError == null && emailError == null;
  }

  ErrorState setErrorMessage(String field, String? value) {
    if (field == 'password') {
      return copyWith(passwordError: () => value);
    }

    if (field == 'resetPassword') {
      return copyWith(resetPassworError: () => value);
    }

    if (field == 'passphrase') {
      return copyWith(passphraseError: () => value);
    }

    if (field == 'tokenName') {
      return copyWith(tokenNameError: () => value);
    }

    if (field == 'email') {
      return copyWith(emailError: () => value);
    }

    return copyWith();
  }

  ErrorState copyWith({
    String? Function()? passwordError,
    String? Function()? resetPassworError,
    String? Function()? passphraseError,
    String? Function()? tokenNameError,
    String? Function()? emailError,
  }) {
    return ErrorState(
      passwordError: passwordError != null ? passwordError() : this.passwordError,
      resetPassworError: resetPassworError != null ? resetPassworError() : this.resetPassworError,
      passphraseError: passphraseError != null ? passphraseError() : this.passphraseError,
      tokenNameError: tokenNameError != null ? tokenNameError() : this.tokenNameError,
      emailError: emailError != null ? emailError() : this.emailError,
    );
  }

  @override
  List<Object?> get props => [passwordError, resetPassworError, passphraseError, tokenNameError, emailError];
}