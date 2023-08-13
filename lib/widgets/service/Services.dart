import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/item/Service.dart';

class ServicesWidget extends StatelessWidget {
  final List<Service> services;

  const ServicesWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: services
            .map((service) => ServiceWidget(service))
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
