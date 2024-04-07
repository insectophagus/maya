import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/screens/home/home_screen.dart';
import 'package:maya/services/storage.dart';

class TextEditor extends StatelessWidget {
  TextEditor({
    super.key,
    this.text = '',
    this.name = '',
    this.entries = const [],
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
  final List<Entry> entries;
  late final QuillController _controller = QuillController.basic()..document = Document.fromJson([{'insert': text}]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorageBloc(RepositoryProvider.of<StorageService>(context)),
      child: BlocConsumer<StorageBloc, StorageState>(
        listener: (context, state) {
          if (state is UpdatedState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              )
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(name, style: const TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                onPressed: () => {
                  context.read<StorageBloc>().add(UpdateStorageEvent(file: Entry(name: name, content: _controller.document.toPlainText()), entries: entries))

                },
                icon: const Icon(Icons.check_circle, size: 34,)
              )
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
        ),
      )
    );
  }
}