import 'package:flutter/material.dart';

class SearchNotesBar extends StatelessWidget {
  const SearchNotesBar({
    super.key,
    required this.searchController,
    required this.onChanged,
  });
  final TextEditingController searchController;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Search notes...',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8.0),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
