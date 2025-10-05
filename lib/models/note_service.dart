import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:isar/isar.dart';

class NoteService extends ChangeNotifier {
  late Isar isar;
  String currentSortOption = 'lastEditDesc';

  NoteService(Isar isarObject) {
    isar = isarObject;
  }

  List<Note> getNotes(String searchQuery) {
    if (searchQuery.isEmpty) {
      return getSortedNotes();
    } else {
      final lowerCaseQuery = searchQuery.toLowerCase();
      return getSortedNotes()
          .where(
            (note) =>
                (note.title != null &&
                    note.title!.toLowerCase().contains(lowerCaseQuery)) ||
                (note.content != null &&
                    note.content!.toLowerCase().contains(lowerCaseQuery)),
          )
          .toList();
    }
  }

  List<Note> getSortedNotes() {
    if (currentSortOption == 'lastEditDesc') {
      return isar.notes.where().sortByLastEditDesc().findAllSync();
    } else if (currentSortOption == 'lastEditAsc') {
      return isar.notes.where().sortByLastEdit().findAllSync();
    } else if (currentSortOption == 'titleAsc') {
      return isar.notes.where().sortByTitle().findAllSync();
    } else if (currentSortOption == 'titleDesc') {
      return isar.notes.where().sortByTitleDesc().findAllSync();
    } else {
      return isar.notes.where().findAllSync();
    }
  }

  void setSortOption(String option) {
    currentSortOption = option;
    notifyListeners();
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
