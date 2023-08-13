import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Belonging.dart';

class BelongingWidget extends StatelessWidget {
  final Belonging belonging;

  const BelongingWidget(this.belonging, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          belonging.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (belonging.description.isNotEmpty) Text(belonging.description),
      ],
    );
  }
}
