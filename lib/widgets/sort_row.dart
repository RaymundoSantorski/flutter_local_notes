import 'package:flutter/material.dart';
import 'package:flutter_local_notes/widgets/sort_opt.dart';

class SortRow extends StatelessWidget {
  const SortRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SortOpt(opt1: 'lastEditAsc', opt2: 'lastEditDesc', label: 'Date'),
        SortOpt(opt1: 'titleAsc', opt2: 'titleDesc', label: 'Title'),
      ],
    );
  }
}
