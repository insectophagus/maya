import 'package:flutter/material.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    Key? key,
    required this.passwordField,
    required this.resetPasswordField,
  }) : super(key: key);

  final TextEditingController passwordField;
  final TextEditingController resetPasswordField;

  @override
  Widget build(BuildContext context) {
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
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        Tooltip(
          message: 'Password to delete all data',
          triggerMode: TooltipTriggerMode.tap,
          child: TextField(
            controller: resetPasswordField,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Terminate password',
            ),
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        const SizedBox(height: 64),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Next')
        )
      ],
    );
  }
}