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
    on<RenameEvent>(rename);
    on<DeleteEvent>(delete);
    on<AddEvent>(addFile);
  }
  
  Future<void> openStorage(OpenStorageEvent event, Emitter<StorageState> emit) async {
    final entries = await _storageService.openStorage();

    emit(EntriesState(entries: entries));
  }

  Future<void> updateStorage(UpdateStorageEvent event, Emitter<StorageState> emit) async {
    final entries = event.entries;
    final file = event.file;
    final updatedEntries = entries.map((e) => e.name == file.name ? file : e);
    final newEntries = await _storageService.updateStorage(updatedEntries, true);

    emit(UpdatedState(entries: newEntries));
  }

  Future<void> rename(RenameEvent event, Emitter<StorageState> emit) async {
    final entries = event.entries;
    final name = event.name;
    final id = event.id;

    final updatedEntries = entries.map((e) => e.id == id ? Entry(name: name, content: e.content, id: id) : e);
    final newEntries = await _storageService.updateStorage(updatedEntries, false);

    emit(RenamedState(entries: newEntries));
  }

  Future<void> delete(DeleteEvent event, Emitter<StorageState> emit) async {
    final entries = event.entries;
    final id = event.id;

    entries.removeWhere((element) => element.id == id);

    final newEntries = await _storageService.updateStorage(entries, false);

    emit(RenamedState(entries: newEntries));
  }

  Future<void> addFile(AddEvent event, Emitter<StorageState> emit) async {
    final entries = event.entries;
    final filePath = event.filePath;
    final entry = await _storageService.openFile(filePath);

    entries.add(entry);

    final newEntries = await _storageService.updateStorage(entries, false);

    emit(AddState(entries: newEntries));
  }
}