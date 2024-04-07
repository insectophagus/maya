import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya/services/storage.dart';

part 'storage_state.dart';
part 'storage_event.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final StorageService _storageService;

  StorageBloc(this._storageService):super(StorageInitial()) {
    on<OpenStorageEvent>(openStorage);
    on<UpdateStorageEvent>(updateStorage);
  }
  
  Future<void> openStorage(OpenStorageEvent event, Emitter<StorageState> emit) async {
    final entries = await _storageService.openStorage();

    emit(EntriesState(entries: entries));
  }

  Future<void> updateStorage(UpdateStorageEvent event, Emitter<StorageState> emit) async {
    final entries = event.entries;
    final file = event.file;
    final updatedEntries = entries.map((e) => e.name == file.name ? file : e);
    final newEntries = await _storageService.updateStorage(updatedEntries);

    emit(UpdatedState(entries: newEntries));
  }
}