import 'package:flutter/material.dart';

class EditNoteTitle extends StatelessWidget {
  const EditNoteTitle({
    super.key,
    required this.titleController,
    required this.onTitleChanged,
  });
  final TextEditingController titleController;
  final Function(String) onTitleChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
