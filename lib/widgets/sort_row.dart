import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note_service.dart';

class SortRow extends StatelessWidget {
  const SortRow({
    super.key,
    required this.currentSort,
    required this.noteService,
  });
  final String currentSort;
  final NoteService noteService;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          onPressed: () {
            noteService.setSortOption(
              currentSort == 'lastEditAsc' ? 'lastEditDesc' : 'lastEditAsc',
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
    );
  }
}
