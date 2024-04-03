part of 'wizard_bloc.dart';

class WizardCubit extends Cubit<ErrorState> {
  WizardCubit() : super(const ErrorState());

  void setError(String field, String? value) {
    emit(const ErrorState().setErrorMessage(field, value));
  }
}