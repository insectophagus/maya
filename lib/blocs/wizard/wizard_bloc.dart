import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/services/wizard.dart';

part 'wizard_state.dart';
part 'wizard_event.dart';
part 'wizard_cubit.dart';

class WizardBloc extends Bloc<WizardEvent, WizardState> {
  final WizardService _wizardService;

  WizardBloc(this._wizardService):super(const WizardState()) {
    on<NextStepEvent>(_onNextStep);
  }

  Future<void> _onNextStep(NextStepEvent event, Emitter<WizardState> emit) async {
    emit(state.copyWith(step: () => 2, password: () => event.password, resetPassword: () => event.resetPassword));
  }
}
