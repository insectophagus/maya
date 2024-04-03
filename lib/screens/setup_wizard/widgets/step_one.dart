import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/wizard/wizard_bloc.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    super.key,
    required this.passwordField,
    required this.resetPasswordField,
  });

  final TextEditingController passwordField;
  final TextEditingController resetPasswordField;

  @override
  Widget build(BuildContext context) {
    final errorCubit = WizardCubit();
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Initial setup - Step 1',
          style: TextStyle(
            fontSize: 30
          ),
        ),
        const SizedBox(height: 55,),
        TextField(
          controller: passwordField,
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            if (value.isEmpty) {
              errorCubit.setError('password', 'Can\'t be empty');
            } else if (value.length < 8) {
              errorCubit.setError('password', 'Too short');
            } else {
              errorCubit.setError('password', null);
            }
          },
          maxLength: 8,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: errorCubit.state.passwordError,
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        Tooltip(
          message: 'Password to delete all data',
          triggerMode: TooltipTriggerMode.tap,
          child: TextField(
            controller: resetPasswordField,
            keyboardType: TextInputType.number,
              onChanged: (String value) {
              if (value.isEmpty) {
                errorCubit.setError('resetPassword', 'Can\'t be empty');
              } else if (value.length < 8) {
                errorCubit.setError('resetPassword', 'Too short');
              } else {
                errorCubit.setError('password', null);
              }
            },
            maxLength: 8,
            enableSuggestions: false,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Terminate password',
              errorText: errorCubit.state.passwordError,
            ),
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        const SizedBox(height: 64),
        ElevatedButton(
          onPressed: () {
            if (errorCubit.state.isValid && passwordField.text.isNotEmpty && resetPasswordField.text.isNotEmpty) {
              context.read<WizardBloc>().add(NextStepEvent(password: passwordField.text, resetPassword: resetPasswordField.text)); 
            }
          },
          child: const Text('Next')
        )
      ],
    );
  }
}