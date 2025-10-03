import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:flutter_local_notes/screens/edit_note_screen.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.notes, required this.noteService});
  final List notes;
  final NoteService noteService;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            onLongPress: () {
              noteService.deleteNote(note.id);
            },
            title: Text(note.title ?? 'No Title'),
            subtitle: Text(
              note.content ?? 'No Content',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen(note: note),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
