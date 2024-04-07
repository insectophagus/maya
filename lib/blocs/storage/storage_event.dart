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