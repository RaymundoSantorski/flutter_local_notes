import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class NewNote extends StatefulWidget {
  NewNote({super.key});

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
          title: TextField(
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: InputBorder.none,
            ),
            onChanged: onTitleChanged,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
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
        body: TextField(
          autofocus: true,
          autocorrect: false,
          maxLines: null,
          onChanged: onContentChanged,
          decoration: const InputDecoration(
            hintText: 'Start typing...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16.0),
          ),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
