part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();
}

class OpenStorageEvent extends StorageEvent {
  @override
  List<Object?> get props => [];
}

class UpdateStorageEvent extends StorageEvent {
  const UpdateStorageEvent({
    required this.file,
    required this.entries
  });

  final Entry file;
  final List<Entry> entries;

  @override
  List<Object?> get props => [file];
}

class RenameEvent extends StorageEvent {
  const RenameEvent({
    required this.name,
    required this.id,
    required this.entries
  });

  final String name;
  final String id;
  final List<Entry> entries;

  @override
  List<Object?> get props => [name, id];
}

class DeleteEvent extends StorageEvent {
  const DeleteEvent({
    required this.id,
    required this.entries
  });

  final String id;
  final List<Entry> entries;

  @override
  List<Object?> get props => [id];
}

class AddEvent extends StorageEvent {
  const AddEvent({
    required this.filePath,
    required this.entries
  });

  final String filePath;
  final List<Entry> entries;

  @override
  List<Object?> get props => [filePath];
}
