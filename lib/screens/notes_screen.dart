import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:flutter_local_notes/screens/edit_note_screen.dart';
import 'package:flutter_local_notes/screens/empty_screen.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteService noteService = Provider.of<NoteService>(context);
    List<Note> notes = noteService.getNotes();
    String currentSort = noteService.currentSortOption;
    return notes.isEmpty
        ? EmptyScreen()
        : SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        noteService.setSortOption(
                          currentSort == 'lastEditAsc'
                              ? 'lastEditDesc'
                              : 'lastEditAsc',
                        );
                      },
                      label: Text('Date'),
                      icon: Icon(
                        currentSort == 'lastEditDesc'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        noteService.setSortOption(
                          currentSort == 'titleAsc' ? 'titleDesc' : 'titleAsc',
                        );
                      },
                      label: Text('Title'),
                      icon: Icon(
                        currentSort == 'titleDesc'
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                      ),
                    ),
                  ],
                ),
                Expanded(
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
                ),
              ],
            ),
          );
  }
}
