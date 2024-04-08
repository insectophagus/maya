import 'package:flutter/material.dart';

class RemoveDialog extends StatelessWidget {
  const RemoveDialog({
    super.key,
    required this.id,
    required this.onSubmit,
    required this.onClose,
  });

  final String id;
  final Function(String id) onSubmit;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(16),
      children: [
        const Text('Are you sure?', style: TextStyle(fontSize: 30)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onSubmit(id);
                onClose();
              },
              child: const Text('Yes')
            ),
            ElevatedButton(
              onPressed: () {
                onClose();
              },
              child: const Text('No')
            )
          ],
        )
      ],
    );
  }
}