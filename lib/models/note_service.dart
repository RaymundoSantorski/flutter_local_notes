import 'package:flutter_local_notes/models/note.dart';
import 'package:isar/isar.dart';

class NoteService {
  static late Isar isar;
  NoteService(Isar isarObject) {
    isar = isarObject;
  }

  static Future<List<Note>> get notes {
    final Future<List<Note>> notes = isar.notes.where().findAll();
    return notes;
  }

  static Future<Note?> getNoteByTitle(String title) async {
    final notesByTitle = isar.notes.filter().titleEqualTo(title).findFirst();
    return notesByTitle;
  }

  static Future<void> createNote({String? title, String? content}) async {
    final newNote = Note()
      ..title = title
      ..content = content
      ..lastEdit = DateTime.now();
    await isar.writeTxn(() async {
      await isar.notes.put(newNote);
    });
  }

  static Future<void> deleteNote(Id id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  static Future<void> updateNote(
    Id id, {
    String? title,
    String? content,
  }) async {
    final note = await isar.notes.get(id);
    if (note == null) return;
    note.title = title;
    note.content = content;
    note.lastEdit = DateTime.now();
    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
  }
}
