import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/Event.dart';
import 'package:freshnet_flutter/widgets/service/item/Label.dart';

class EventWidget extends StatelessWidget {
  final ServiceEvent event;

  const EventWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      event.timestamp.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: event.method.color,
                      ),
                      child: Center(
                        child: Text(
                          event.method.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      event.username,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ].fold([], (previousValue, element) {
                    previousValue.add(element);
                    previousValue.add(Container(
                      width: 3,
                      height: 3,
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black45,
                      ),
                    ));

                    return previousValue;
                  }),
                ),
                Text(event.description),
                const Row(children: [
                  LabelWidget(title: 'Label1'),
                  LabelWidget(title: 'Label2'),
                  LabelWidget(title: 'Label3'),
                ])
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                  value: 'edit-description', child: Text('Edit Description')),
              const PopupMenuItem<String>(
                  value: 'delete-event', child: Text('Delete Event')),
            ],
          ),
        ],
      ),
    );
  }
}
