import 'package:flutter_local_notes/models/note.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteService {
  static late Isar isar;
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final auxIsar = await Isar.open([NoteSchema], directory: dir.path);
    isar = auxIsar;
  }

  static Future<List<Note>> get notes {
    final Future<List<Note>> notes = isar.notes.where().findAll();
    return notes;
  }

  static void createNote({String? title, String? content}) async {
    final newNote = Note()
      ..title = title
      ..content = content
      ..lastEdit = DateTime.now();
    isar.writeTxn(() async {
      await isar.notes.put(newNote);
    });
  }

  static void deleteNote(Id id) async {
    await isar.writeTxn(() async {
      await isar.notes.delete(id);
    });
  }

  static updateNote(Id id, {String? title, String? content}) async {
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
