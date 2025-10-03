import 'package:flutter/material.dart';

class NewNoteContent extends StatelessWidget {
  const NewNoteContent({super.key, required this.onContentChanged});
  final Function(String) onContentChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      autocorrect: false,
      maxLines: null,
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
