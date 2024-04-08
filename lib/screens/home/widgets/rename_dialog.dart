import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';

class RenameDialog extends StatelessWidget {
  RenameDialog({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.onClose,
    required this.entries
  });

  final String title;
  final List<Entry> entries;
  late final TextEditingController titleField = TextEditingController.fromValue(TextEditingValue(text: title));
  final Function(String value) onSubmit;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: titleField,
          enableSuggestions: false,
          autocorrect: false,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onSubmit(titleField.text);
                onClose();
              },
              child: const Text('Save')
            ),
            ElevatedButton(
              onPressed: () {
                onClose();
              },
              child: const Text('Cancel')
            )
          ],
        )
      ],
    );
  }
}