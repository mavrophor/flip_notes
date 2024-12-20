import 'dart:async';

import 'package:flip_notes/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NotesLocalRepo {
  NotesLocalRepo({required this.db});

  Database db;
  final String notesTable = 'notes';
  static String get _now => DateTime.now().copyWith(microsecond: 0).toUtc().toIso8601String();

  ///get notes in set order, then by creation date
  Future<List<Note>> getList({
    NoteFields sortByField = NoteFields.createdAt,
    bool descending = false,
  }) async {
    final localData = await db.rawQuery('''
    SELECT
      $notesTable.${NoteFields.id.name},
      $notesTable.${NoteFields.title.name},
      $notesTable.${NoteFields.contentFront.name},
      $notesTable.${NoteFields.contentBack.name},
      $notesTable.${NoteFields.color.name},
      $notesTable.${NoteFields.tags.name},
      $notesTable.${NoteFields.createdAt.name},
      $notesTable.${NoteFields.updatedAt.name}
    FROM $notesTable
    WHERE $notesTable.${NoteFields.deletedAt.name} IS NULL
    ORDER BY $notesTable.${sortByField.name} ${descending ? 'DESC' : 'ASC'}
      ${sortByField == NoteFields.createdAt ? '' : ', notes.${NoteFields.createdAt.name}'}
    ''');
    Iterable<Note> notes = localData.map((e) => Note.fromMap(e));
    return notes.toList();
  }

  ///get a single note by id if exists
  Future<Note?> getNote(String id) async {
    final entries = await db.rawQuery(
      '''SELECT
    $notesTable.${NoteFields.id.name},
    $notesTable.${NoteFields.title.name},
    $notesTable.${NoteFields.contentFront.name},
    $notesTable.${NoteFields.contentBack.name},
    $notesTable.${NoteFields.color.name},
    $notesTable.${NoteFields.tags.name},
    $notesTable.${NoteFields.createdAt.name},
    $notesTable.${NoteFields.updatedAt.name}
      WHERE notes.id = ?''',
      [id],
    );
    if (entries.isEmpty) return null;
    return Note.fromMap(entries.first);
  }

  ///save a note in local db
  Future<bool> saveNote({required Note note}) async {
    final checkId = await db.insert(notesTable, note.toMap());
    return checkId != 0;
  }

  ///soft delete a note in local db, and return whether a note was deleted
  Future<bool> deleteNote(String deletedNoteId) async {
    final now = _now;
    final checkId = await db.update(
      notesTable,
      {'deletedAt': now, 'updatedAt': now},
      where: 'id = ?',
      whereArgs: [deletedNoteId],
    );
    return checkId != 0;
  }

  ///update a note and return if updated
  Future<bool> updateNote({required Note note}) async {
    final checkId = await db.update(
      notesTable,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    return checkId != 0;
  }
}
