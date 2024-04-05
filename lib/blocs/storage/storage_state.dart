part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState({
    this.entries = const [],
  });

  final List<TarEntry> entries;
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
  final List<TarEntry> entries;

  @override
  List<Object?> get props => [entries];
}