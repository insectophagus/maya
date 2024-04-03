part of 'wizard_bloc.dart';

abstract class WizardEvent extends Equatable {
  const WizardEvent();

  @override
  List<Object> get props => [];
}

class NextStepEvent extends WizardEvent {
  const NextStepEvent({
    required this.password,
    required this.resetPassword
  });

  final String password;
  final String resetPassword;

  @override
  List<Object> get props => [2, password, resetPassword];
}

class SaveSettingsEvent extends WizardEvent {
  const SaveSettingsEvent({
    required this.password,
    required this.resetPassword,
    required this.passphrase,
    required this.tokenName,
    required this.email,
  });

  final String password;
  final String resetPassword;
  final String passphrase;
  final String tokenName;
  final String email;

  @override
  List<Object> get props => [password, resetPassword, passphrase, tokenName, email];
}
