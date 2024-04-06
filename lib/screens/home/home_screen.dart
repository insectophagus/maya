import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My storage')),
      body: BlocProvider(
        create: (context) => StorageBloc(
          RepositoryProvider.of<StorageService>(context)
        )..add(OpenStorageEvent()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: BlocConsumer<StorageBloc, StorageState>(
            builder: (context, state) {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.entries.map<Widget>((e) => TextFile(title: e.name, value: e.content,)).toList(),
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
    );
  }
}
