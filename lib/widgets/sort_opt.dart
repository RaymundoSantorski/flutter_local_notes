import 'package:flutter/material.dart';
import 'package:flutter_local_notes/models/note_service.dart';
import 'package:provider/provider.dart';

class SortOpt extends StatelessWidget {
  const SortOpt({
    super.key,
    required this.opt1,
    required this.opt2,
    required this.label,
  });
  final String label;
  final String opt1;
  final String opt2;

  @override
  Widget build(BuildContext context) {
    NoteService noteService = Provider.of<NoteService>(context);
    String currentSort = noteService.currentSortOption;

    return TextButton.icon(
      onPressed: () {
        noteService.setSortOption(currentSort == opt1 ? opt2 : opt1);
      },
      label: Text(label),
      icon: Icon(
        currentSort == opt2 ? Icons.arrow_downward : Icons.arrow_upward,
      ),
    );
  }
}
