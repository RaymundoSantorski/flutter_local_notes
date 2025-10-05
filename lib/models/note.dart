import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  String? title;
  String? content;
  DateTime createdAt = DateTime.now();
  DateTime? lastEdit;
}
