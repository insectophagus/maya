import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/blocs/storage/storage_bloc.dart';
import 'package:maya/services/storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

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
              return const Center(child: Text('home'));
            },
            listener: (context, state) {

            }
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(child: Text('Māyā'))
          ],
        ),
      ),
    );
  }
}