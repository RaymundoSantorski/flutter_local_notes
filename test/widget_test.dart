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

  setUpAll(() async {
    tempDirPath = Directory.systemTemp.createTempSync().path;
    PathProviderPlatform.instance = _MockPathProvider(tempDirPath);
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], name: 'testDB', directory: dir.path);
    NoteService(isar);
  });

  tearDown(() async {
    await isar.writeTxn(() => isar.notes.clear());
    await isar.close(deleteFromDisk: true);
    Directory(tempDirPath).deleteSync(recursive: true);
  });

  test('Debe añadir una nota', () async {
    await NoteService.createNote(title: 'Nota 1', content: '');

    final Note? note = await isar.notes
        .filter()
        .titleEqualTo('Nota 1')
        .findFirst();

    expect(note, isNotNull);
    expect(note!.content, '');
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
