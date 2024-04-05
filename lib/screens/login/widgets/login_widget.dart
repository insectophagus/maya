import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/login/login_bloc.dart';

class Login extends StatelessWidget {
  const Login({
    super.key,
    required this.passwordField,
  });

  final TextEditingController passwordField;

  @override
  Widget build(BuildContext context) {  
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Log In',
          style: TextStyle(
            fontSize: 30
          ),
        ),
        const SizedBox(height: 55,),
        TextField(
          controller: passwordField,
          keyboardType: TextInputType.number,
          maxLength: 8,
          enableSuggestions: false,
          autocorrect: false,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 64),
        ElevatedButton(
          onPressed: () {
            context.read<LoginBloc>().add(SignInEvent(passwordField.text));
          },
          child: const Text('Log in')
        )
      ],
    );
  }
}