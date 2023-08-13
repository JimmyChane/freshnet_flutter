import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Label.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/datas/State.dart';
import 'package:freshnet_flutter/widgets/service/StateSelector.dart';
import 'package:freshnet_flutter/widgets/service/section/SectionAddServiceEvent.dart';
import 'package:freshnet_flutter/widgets/service/section/SectionBelongings.dart';
import 'package:freshnet_flutter/widgets/service/section/SectionCollected.dart';
import 'package:freshnet_flutter/widgets/service/section/SectionDescription.dart';
import 'package:freshnet_flutter/widgets/service/section/SectionEvents.dart';
import 'package:freshnet_flutter/widgets/service/section/SectionImages.dart';

class ServiceItemPage extends StatefulWidget {
  final Service service;
  ServiceState? currentState;

  ServiceItemPage({super.key, required this.service}) {
    currentState = service.state;
  }

  @override
  State<ServiceItemPage> createState() => _ServiceItemPageState();
}

class _ServiceItemPageState extends State<ServiceItemPage> {
  final String title = 'Service Page';

  String getCustomerName() {
    return widget.service.customer?.name ?? '';
  }

  String getPhoneNumber() {
    return widget.service.customer?.phoneNumber?.toString() ?? '';
  }

  String getTimestamp() {
    return widget.service.timestamp.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E0DA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (getCustomerName().isNotEmpty)
                  Text(getCustomerName(), style: const TextStyle(fontSize: 12)),
                if (getPhoneNumber().isNotEmpty)
                  Text(getPhoneNumber(), style: const TextStyle(fontSize: 12)),
              ],
            ),
            if (getTimestamp().isNotEmpty)
              Text(getTimestamp(), style: const TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'find-customer':
                  break;
                case 'delete-service':
                  widget.service.delete();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                  value: 'find-customer', child: Text('Find Customer')),
              const PopupMenuItem<String>(
                  value: 'delete-service', child: Text('Delete Service')),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StateSelectorWidget(
                serviceState: widget.currentState,
                onChanged: (ServiceState? newValue) {
                  widget.service.updateState(newValue).then((Service service) {
                    setState(() => widget.currentState = service.state);
                  });
                },
              ),
              Wrap(
                direction: Axis.horizontal,
                spacing: 4,
                children: widget.service.labels.map((e) {
                  return LabelWidget(label: e);
                }).toList(),
              ),
            ],
          ),
          const SectionAddServiceEventWidget(),
          EventsWidget(service: widget.service),
          SectionDescriptionWidget(service: widget.service),
          SectionBelongingsWidget(service: widget.service),
          SectionImagesWidget(service: widget.service),
          SectionCollectedWidget(service: widget.service),
        ]),
      ),
    );
  }
}

class LabelWidget extends StatelessWidget {
  final ServiceLabel label;

  const LabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: label.color,
      ),
      child: Text(
        label.title,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
