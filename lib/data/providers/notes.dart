import 'package:flip_notes/data/models/note_model.dart';
import 'package:flip_notes/data/repositories/dummy_notes_repo.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:collection/collection.dart';

part 'notes.g.dart';

@Riverpod(keepAlive: true)
class Notes extends _$Notes {
  final _repo = DummyNotesRepo();

  @override
  FutureOr<List<Note>> build() async {
    final list = await _repo.getList();
    return list;
  }

  //reload
  Future<void> reload() async {
    if (state.isLoading) return;
    state = const AsyncLoading();
    ref.invalidateSelf();
  }

  FutureOr<Note?> getNoteFromState(String? noteId) async {
    if (noteId == null) return null;
    if (state.isLoading) await ref.read(notesProvider.future);
    if (!state.hasValue) return null;
    final note = state.value!.firstWhereOrNull((e) => e.id == noteId);
    return note;
  }

  FutureOr<void> addDummyNotes() async {
    final dummyNotes = await _repo.generateNotes(amount: 12);
    state = AsyncData([...state.value ?? [], ...dummyNotes]);
  }

  //temp implementation
  Future<bool> updateNote({
    required String id,
    String? title,
    String? contentFront,
    String? contentBack,
    Color? color,
    Set<String>? tags,
  }) async {
    if (!state.hasValue) return false;
    final index = state.value!.indexWhere((note) => note.id == id);
    if (index < 0) return false;
    state.value![index] = state.value![index].copyWith(
      title: title,
      contentFront: contentFront,
      contentBack: contentBack,
      color: color,
      tags: tags,
      updatedAt: DateTime.now(),
    );
    return true;
  }

  //temp implementation
  FutureOr<bool> deleteNotes(List<String> listOfIds) async {
    if (!state.hasValue) return false;
    state = const AsyncLoading();
    final notes = state.value!;
    state = AsyncData(
      notes.map((note) => listOfIds.contains(note.id) ? note.copyWith(deletedAt: () => DateTime.now()) : note).toList(),
    );
    return true;
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
