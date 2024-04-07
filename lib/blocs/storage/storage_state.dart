part of 'storage_bloc.dart';

class Entry {
  Entry({
    this.name = '',
    this.content = ''
  });

  late String name;
  late String content;
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