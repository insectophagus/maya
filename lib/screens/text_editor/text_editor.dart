import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditor extends StatelessWidget {
  TextEditor({
    super.key,
    this.text = '',
    this.name = ''
  });

  static const String routeName = '/text_editor';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => TextEditor(),
      settings: const RouteSettings(name: routeName)
    );
  }

  final String text; 
  final String name; 
  late final QuillController _controller = QuillController.basic()..document = Document.fromJson([{'insert': text}]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.check_circle, size: 34,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Expanded(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: _controller,
                  readOnly: false,
                  
                )
              )
            )
          ],
        ),
      ),
    );
  }
}