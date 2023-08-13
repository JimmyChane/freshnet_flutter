import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String title;

  const LabelWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Text('Label1');
  }
}
