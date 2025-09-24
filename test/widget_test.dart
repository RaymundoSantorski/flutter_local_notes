import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Isar isar;
  late String tempDirPath;
  late NoteService noteService;

  setUpAll(() async {
    tempDirPath = Directory.systemTemp.createTempSync().path;
    PathProviderPlatform.instance = _MockPathProvider(tempDirPath);
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], name: 'testDB', directory: dir.path);
    noteService = NoteService(isar);
  });

  tearDown(() async {
    await isar.writeTxn(() => isar.notes.clear());
    await isar.close(deleteFromDisk: true);
  });

  tearDownAll(() async {
    Directory(tempDirPath).deleteSync(recursive: true);
  });

  test('Debe añadir una nota y obtenerla por titulo', () async {
    await noteService.createNote(title: 'Nota 1', content: '');

    final Note? note = await noteService.getNoteByTitle('Nota 1');

    expect(note, isNotNull);
    expect(note!.content, '');
  });

  test('Debe añadir una nota y eliminarla correctamente', () async {
    await noteService.createNote(title: 'Nota 2', content: '');

    List<Note> notes = await noteService.notes;
    expect(notes, isNotEmpty);

    final Note? note = await noteService.getNoteByTitle('Nota 2');
    expect(note, isNotNull);

    await noteService.deleteNote(note!.id);
    notes = await noteService.notes;
    expect(notes, isEmpty);
  });

  test('Debe actualizar una nota correctamente', () async {
    await noteService.createNote(
      title: 'Nota a actualizar',
      content: 'Contenido original',
    );
    final Note? originalNote = await noteService.getNoteByTitle(
      'Nota a actualizar',
    );

    expect(originalNote, isNotNull);
    expect(originalNote!.content, 'Contenido original');

    final newTitle = 'Nota actualizada';
    final newContent = 'Nuevo contenido';
    await noteService.updateNote(
      originalNote.id,
      title: newTitle,
      content: newContent,
    );

    final Note? updatedNote = await noteService.getNoteByTitle(newTitle);

    expect(updatedNote, isNotNull);
    expect(updatedNote!.title, newTitle);
    expect(updatedNote.content, newContent);
    expect(updatedNote.lastEdit, isNot(originalNote.lastEdit));
  });
}

class _MockPathProvider extends PathProviderPlatform {
  final String mockPath;
  _MockPathProvider(this.mockPath);

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return mockPath;
  }
}
