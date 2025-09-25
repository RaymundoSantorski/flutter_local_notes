import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:isar/isar.dart';

class NoteService extends ChangeNotifier {
  late Isar isar;
  NoteService(Isar isarObject) {
    isar = isarObject;
  }

  List<Note> get notes {
    final List<Note> notes = isar.notes.where().findAllSync();
    return notes;
  }

  Future<Note?> getNoteByTitle(String title) async {
    final notesByTitle = isar.notes.filter().titleEqualTo(title).findFirst();
    return notesByTitle;
  }

  Future<Note> createNote({String? title, String? content}) async {
    final newNote = Note()
      ..title = title
      ..content = content
      ..lastEdit = DateTime.now();
    await isar.writeTxn(() async {
      await isar.notes.put(newNote);
    });
    notifyListeners();
    return newNote;
  }

  Future<void> addNote(Note note) async {
    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
    notifyListeners();
  }

  Future<void> deleteNote(Id id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
    notifyListeners();
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
    notifyListeners();
  }
}
