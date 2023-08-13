import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/item/Event.dart';

class EventsWidget extends StatelessWidget {
  final Service service;

  const EventsWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${service.events.length > 1 ? 'Events' : 'Event'}(${service.events.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Total cost: RM 0.00',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            ...service.events.map((event) {
              return EventWidget(event: event);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
