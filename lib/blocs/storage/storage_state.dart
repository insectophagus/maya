part of 'storage_bloc.dart';

class Entry {
  Entry({
    this.name = '',
    this.content = '',
    this.id = ''
  });

  late String name;
  late String content;
  late String id;
}
abstract class StorageState extends Equatable {
  const StorageState({
    this.entries = const [],
  });

  final List<Entry> entries;
}

class StorageInitial extends StorageState {
  @override
  List<Object> get props => [];
}

class EntriesState extends StorageState {
  const EntriesState({
    this.entries = const [],
  });

  @override
  final List<Entry> entries;

  @override
  List<Object?> get props => [entries];
}

class UpdatedState extends StorageState {
  const UpdatedState({
    this.entries = const [],
  });

  @override
  final List<Entry> entries;

  @override
  List<Object?> get props => [entries];
}

class RenamedState extends StorageState {
  const RenamedState({
    this.entries = const [],
  });

  @override
  final List<Entry> entries;

  @override
  List<Object?> get props => [entries];
}