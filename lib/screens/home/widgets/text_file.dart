import 'package:flutter/material.dart';
import 'package:maya/screens/text_editor/text_editor.dart';
import 'package:maya/utils/decrypt_value.dart';

class TextFile extends StatelessWidget {
  const TextFile({
    super.key, 
    this.title = '',
    this.value = ''
  });

  final String title;
  final String value;

  Future<void> openFile(BuildContext context) async {
    final decryptedValue = await DecryptValue.decrypt(value);
  
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TextEditor(text: decryptedValue, name: title),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openFile(context),
      child: Column(
        children: [
          const Icon(
            Icons.text_snippet,
            color: Colors.blueGrey,
            size: 64,
            semanticLabel: 'file',
          ),
          Text(title)
        ]
      ),
    );
  }
}