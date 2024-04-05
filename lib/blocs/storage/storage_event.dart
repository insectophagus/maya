part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();
}

class OpenStorageEvent extends StorageEvent {
  @override
  List<Object?> get props => [];
}
