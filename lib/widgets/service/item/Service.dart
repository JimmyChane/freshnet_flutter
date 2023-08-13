import 'package:flutter/material.dart';
import 'package:freshnet_flutter/widgets/service/ServiceViewer.dart';
import 'package:freshnet_flutter/datas/Service.dart';

class ServiceWidget extends StatelessWidget {
  final Service service;

  const ServiceWidget(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceItemPage(service: service),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 4, color: service.state.color),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.timestamp.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        service.customer?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        service.customer?.phoneNumber?.toString() ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(color: Colors.black, thickness: 0.1),
                      Text(
                        service.description,
                        style: const TextStyle(color: Colors.black),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 4,
                        children: service.labels
                            .map((e) => LabelWidget(label: e))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
