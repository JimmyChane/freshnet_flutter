import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Service.dart';

class PanelEditDescriptionWidget extends StatelessWidget {
  final Service service;

  const PanelEditDescriptionWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        maxLines: null,
        controller: TextEditingController(
          text: service.description,
        ),
      ),
    );
  }
}
