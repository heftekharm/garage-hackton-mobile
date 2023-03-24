import 'package:flutter/material.dart';

class FilledCircle extends StatelessWidget {
  const FilledCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: 550,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
    );
  }
}
