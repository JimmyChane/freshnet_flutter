import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/section/Section.dart';

class SectionCollectedWidget extends StatelessWidget {
  final Service service;

  const SectionCollectedWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Collected By',
      body: Column(
        children: [
          Text(service.username),
          Text(service.name),
        ],
      ),
    );
  }
}
