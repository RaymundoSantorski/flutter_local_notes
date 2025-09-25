import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key, required this.note});
  final Note note;

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  late String title;
  late String content;
  @override
  void initState() {
    super.initState();
    title = widget.note.title ?? '';
    content = widget.note.content ?? '';
    titleController = TextEditingController(text: widget.note.title);
    contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = Provider.of<NoteService>(context);

    Future saveNote() async {
      await noteService.updateNote(
        widget.note.id,
        title: title,
        content: content,
      );
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

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autocorrect: false,
          controller: titleController,
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
        controller: contentController,
        onChanged: onContentChanged,
        decoration: const InputDecoration(
          hintText: 'Start typing...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
    ;
  }
}
