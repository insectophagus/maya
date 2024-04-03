import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/wizard/wizard_bloc.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({
    super.key,
    required this.passphraseField,
    required this.tokenNameField,
    required this.emailField,
  });

  final TextEditingController passphraseField;
  final TextEditingController tokenNameField;
  final TextEditingController emailField;

  @override
  Widget build(BuildContext context) {
    final errorCubit = WizardCubit();
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Initial setup - Step 2',
          style: TextStyle(
            fontSize: 30
          ),
        ),
        const SizedBox(height: 55,),
        TextField(
          controller: emailField,
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            if (value.isEmpty) {
              errorCubit.setError('email', 'Can\'t be empty');
            } else {
              errorCubit.setError('password', null);
            }
          },
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: errorCubit.state.emailError,
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        TextField(
          controller: tokenNameField,
            onChanged: (String value) {
            if (value.isEmpty) {
              errorCubit.setError('tokenName', 'Can\'t be empty');
            } else {
              errorCubit.setError('tokenName', null);
            }
          },
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: 'Token name',
            errorText: errorCubit.state.tokenNameError,
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        TextField(
          controller: passphraseField,
            onChanged: (String value) {
            if (value.isEmpty) {
              errorCubit.setError('passphrase', 'Can\'t be empty');
            } else {
              errorCubit.setError('passphrase', null);
            }
          },
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            labelText: 'Passphrase',
            errorText: errorCubit.state.passphraseError,
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 64),
        ElevatedButton(
          onPressed: () {
            if (errorCubit.state.isValid && emailField.text.isNotEmpty && tokenNameField.text.isNotEmpty && passphraseField.text.isNotEmpty) {
              final state = context.read<WizardBloc>().state;

              context.read<WizardBloc>().add(SaveSettingsEvent(
                password: state.password,
                resetPassword: state.resetPassword,
                passphrase: passphraseField.text,
                tokenName: tokenNameField.text,
                email: emailField.text)
              ); 
            }
          },
          child: const Text('Save')
        )
      ],
    );
  }
}