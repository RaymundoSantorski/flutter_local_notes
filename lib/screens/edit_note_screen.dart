import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:flutter_local_notes/widgets/edit_note_content.dart';
import 'package:flutter_local_notes/widgets/edit_note_title.dart';
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

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (title.isEmpty && content.isEmpty) {
            noteService.deleteNote(widget.note.id);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: EditNoteTitle(
            titleController: titleController,
            onTitleChanged: onTitleChanged,
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
        body: EditNoteContent(
          contentController: contentController,
          onContentChanged: onContentChanged,
        ),
      ),
    );
  }
}
