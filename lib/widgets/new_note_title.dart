import 'package:flutter/material.dart';

class NewNoteTitle extends StatelessWidget {
  const NewNoteTitle({super.key, required this.onTitleChanged});
  final Function(String) onTitleChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
