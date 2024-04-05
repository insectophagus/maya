import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/services/storage.dart';
import 'package:tar/tar.dart';

part 'storage_state.dart';
part 'storage_event.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final StorageService _storageService;

  StorageBloc(this._storageService):super(StorageInitial()) {
    on<OpenStorageEvent>(openStorage);
  }
  
  Future<void> openStorage(OpenStorageEvent event, Emitter<StorageState> emit) async {
    final entries = await _storageService.openStorage();

    emit(EntriesState(entries: entries));
  }
}