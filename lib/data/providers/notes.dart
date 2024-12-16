import 'package:flip_notes/data/models/note_model.dart';
import 'package:flip_notes/data/repositories/dummy_notes_repo.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notes.g.dart';

@riverpod
class Notes extends _$Notes {
  final _repo = DummyNotesRepo();

  @override
  FutureOr<List<Note>> build() async {
    final list = await _repo.getList();
    return list;
  }

  //temp implementation
  Future<bool> updateNote(String id, Note updatedNote) async {
    if (!state.hasValue) return false;
    final index = state.value!.indexWhere((note) => note.id == id);
    if (index < 0) return false;
    state.value![index] = updatedNote;
    return true;
  }

  //temp implementation
  FutureOr<void> deleteNotes(List<String> listOfIds) async {
    if (!state.hasValue) return;
    state = const AsyncLoading();
    final notes = state.value!;
    notes.removeWhere((note) => listOfIds.contains(note.id));
    state = AsyncData(notes);
  }

  //temp implementation
  FutureOr<void> createNote({
    required String title,
    required String contentFront,
    required String contentBack,
    required Color color,
    List<String>? tags,
  }) async {
    final note = await _repo.create(
      title: title,
      contentFront: contentFront,
      contentBack: contentBack,
      color: color,
    );
    state = AsyncData([...state.value ?? [], note]);
  }
}
