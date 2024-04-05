part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();
}

class StorageInitial extends StorageState {
  @override
  List<Object> get props => [];
}