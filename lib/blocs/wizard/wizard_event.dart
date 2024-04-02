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