import 'package:flutter_local_notes/models/note.dart';
import 'package:isar/isar.dart';

class NoteService {
  late Isar isar;
  NoteService(this.isar);

  Future<List<Note>> get notes {
    final Future<List<Note>> notes = isar.notes.where().findAll();
    return notes;
  }

  Future<Note?> getNoteByTitle(String title) async {
    final notesByTitle = isar.notes.filter().titleEqualTo(title).findFirst();
    return notesByTitle;
  }

  Future<void> createNote({String? title, String? content}) async {
    final newNote = Note()
      ..title = title
      ..content = content
      ..lastEdit = DateTime.now();
    isar.writeTxn(() async {
      await isar.notes.put(newNote);
    });
  }

  Future<void> deleteNote(Id id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  Future<void> updateNote(Id id, {String? title, String? content}) async {
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
