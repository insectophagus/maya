import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/screens/home/widgets/remove_dialog.dart';
import 'package:maya/screens/home/widgets/rename_dialog.dart';
import 'package:maya/screens/text_editor/text_editor.dart';
import 'package:maya/utils/decrypt_value.dart';
import 'package:popover/popover.dart';

class TextFile extends StatelessWidget {
  const TextFile({
    super.key, 
    this.title = '',
    this.id = '',
    this.value = '',
    this.entries = const [],
    required this.onRename,
    required this.onRemove,
  });

  final String title;
  final String id;
  final String value;
  final List<Entry> entries;
  final Function(String value) onRename;
  final Function(String value) onRemove;

  Future<void> openFile(BuildContext context) async {
    final decryptedValue = await DecryptValue.decrypt(value);
  
    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TextEditor(text: decryptedValue, name: title, entries: entries,),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () => openFile(context),
      child: GestureDetector(
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
        onSecondaryTap: () {
          showPopover(
            context: context,
            direction: PopoverDirection.bottom,
            width: 100,
            height: 70,
            bodyBuilder: (context) =>  Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RenameDialog(
                            title: title,
                            entries: entries,
                            onSubmit: (value) {
                              onRename(value);
                            },
                            onClose: () {
                              Navigator.pop(context);
                            }
                          );
                        }
                      );
                    },
                    child: const Center(child: Text('Rename')),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RemoveDialog(
                            id: id,
                            onSubmit: (value) {
                              onRemove(value);
                            },
                            onClose: () {
                              Navigator.pop(context);
                            }
                          );
                        }
                      );
                    },
                    child: const Center(child: Text('Remove')),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}