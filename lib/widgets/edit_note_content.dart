import 'package:flutter/material.dart';

class EditNoteContent extends StatelessWidget {
  const EditNoteContent({
    super.key,
    required this.contentController,
    required this.onContentChanged,
  });
  final TextEditingController contentController;
  final Function(String) onContentChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
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
    );
  }
}
