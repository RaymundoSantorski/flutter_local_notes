import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:flutter_local_notes/widgets/new_note_content.dart';
import 'package:flutter_local_notes/widgets/new_note_title.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  String title = '';

  String content = '';
  Id? id;
  Note? note;

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = Provider.of<NoteService>(context);

    void saveNote() async {
      if (id == null) {
        note = await noteService.createNote(title: title, content: content);
        id = note!.id;
      } else {
        noteService.updateNote(id!, title: title, content: content);
      }
    }

    void onTitleChanged(String value) {
      setState(() {
        title = value;
      });
      saveNote();
    }

    void onContentChanged(String value) {
      setState(() {
        content = value;
      });
      saveNote();
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (id != null && (title.isEmpty && content.isEmpty)) {
            noteService.deleteNote(id!);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: NewNoteTitle(onTitleChanged: onTitleChanged),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                saveNote();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: NewNoteContent(onContentChanged: onContentChanged),
      ),
    );
  }
}
