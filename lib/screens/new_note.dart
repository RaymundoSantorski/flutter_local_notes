import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:isar/isar.dart';

class NewNote extends StatefulWidget {
  NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  String title = '';

  String content = '';
  late Id id;

  @override
  Widget build(BuildContext context) {
    void saveNote() {
      if (id == null) {
        final newNote = Note()
          ..title = title
          ..content = content
          ..lastEdit = DateTime.now();
      } else {
        // Lógica para actualizar la nota existente en la base de datos
      }
    }

    void onTitleChanged(String value) {
      setState(() {
        title = value;
      });
    }

    void onContentChanged(String value) {
      setState(() {
        content = value;
      });
    }

    return Scaffold(
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
            icon: const Icon(Icons.save_outlined),
            onPressed: () {
              // Lógica para guardar la nota
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
    );
  }
}
