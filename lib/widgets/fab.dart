import 'package:flutter/material.dart';
import 'package:flutter_local_notes/screens/new_note.dart';

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewNote()),
        );
      },
      tooltip: 'Add Note',
      child: const Icon(Icons.add),
    );
  }
}
