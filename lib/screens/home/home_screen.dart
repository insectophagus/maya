import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/screens/home/widgets/text_file.dart';
import 'package:maya/services/storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(),
      settings: const RouteSettings(name: routeName)
    );
  }

  Future<void> addFile(BuildContext context, List<Entry> entries) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (context.mounted) {
        context.read<StorageBloc>().add(AddEvent(filePath: result.files.single.path!, entries: entries));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorageBloc(
        RepositoryProvider.of<StorageService>(context)
      )..add(OpenStorageEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My storage'),
          actions: [
            IconButton(
              onPressed: () => {
                addFile(context, entries)
              },
              icon: const Icon(Icons.check_circle, size: 34,)
            )
          ],
        ),
        body: BlocProvider(
          create: (context) => StorageBloc(
            RepositoryProvider.of<StorageService>(context)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BlocConsumer<StorageBloc, StorageState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.entries.map<Widget>((e) => TextFile(
                    title: e.name,
                    id: e.id,
                    value: e.content,
                    entries: state.entries,
                    onRename: (value) {
                      context.read<StorageBloc>().add(RenameEvent(
                        name: value,
                        id: e.id,
                        entries: state.entries
                      ));
                    },
                    onRemove: (value) {
                      context.read<StorageBloc>().add(DeleteEvent(
                        id: e.id,
                        entries: state.entries
                      ));
                    },
                  )).toList(),
                );
              },
              listener: (context, state) {
                print(state.entries);
              }
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(child: Center(child: Text('Māyā', style: TextStyle(fontSize: 32, color: Colors.black)))),
              ListTile(title: const Text('My storage'), onTap: () {},),
              ListTile(title: const Text('Devices'), onTap: () {}),
              ListTile(title: const Text('Settings'), onTap: () {})
            ]
          ),
        ),
      );,
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('My storage'),
    //     actions: [
    //       IconButton(
    //         onPressed: () => {
    //           addFile(context, entries)
    //         },
    //         icon: const Icon(Icons.check_circle, size: 34,)
    //       )
    //     ],
    //   ),
    //   body: BlocProvider(
    //     create: (context) => StorageBloc(
    //       RepositoryProvider.of<StorageService>(context)
    //     )..add(OpenStorageEvent()),
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 25),
    //       child: BlocConsumer<StorageBloc, StorageState>(
    //         builder: (context, state) {
    //           return Wrap(
    //             spacing: 8,
    //             runSpacing: 8,
    //             children: state.entries.map<Widget>((e) => TextFile(
    //               title: e.name,
    //               id: e.id,
    //               value: e.content,
    //               entries: state.entries,
    //               onRename: (value) {
    //                 context.read<StorageBloc>().add(RenameEvent(
    //                   name: value,
    //                   id: e.id,
    //                   entries: state.entries
    //                 ));
    //               },
    //               onRemove: (value) {
    //                 context.read<StorageBloc>().add(DeleteEvent(
    //                   id: e.id,
    //                   entries: state.entries
    //                 ));
    //               },
    //             )).toList(),
    //           );
    //         },
    //         listener: (context, state) {
    //           print(state.entries);
    //         }
    //       ),
    //     ),
    //   ),
    //   drawer: Drawer(
    //     child: ListView(
    //       padding: EdgeInsets.zero,
    //       children: [
    //         const DrawerHeader(child: Center(child: Text('Māyā', style: TextStyle(fontSize: 32, color: Colors.black)))),
    //         ListTile(title: const Text('My storage'), onTap: () {},),
    //         ListTile(title: const Text('Devices'), onTap: () {}),
    //         ListTile(title: const Text('Settings'), onTap: () {})
    //       ]
    //     ),
    //   ),
    // );
  }
}
