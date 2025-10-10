import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:flutter_local_notes/screens/empty_screen.dart';
import 'package:flutter_local_notes/widgets/notes_list.dart';
import 'package:flutter_local_notes/widgets/sort_row.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key, required this.searchQuery});
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = Provider.of<NoteService>(context);
    List<Note> notes = noteService.getNotes(searchQuery);
    return notes.isEmpty
        ? EmptyScreen()
        : SafeArea(
            child: Column(
              children: [
                SortRow(),
                NotesList(notes: notes, noteService: noteService),
              ],
            ),
          );
  }
}
