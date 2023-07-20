import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshnet_flutter/Data.dart';

class ServicePage extends StatelessWidget {
  final Service service;
  final String title = 'Service Page';

  ServicePage({super.key, required this.service});

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
                Text(
                  service.customer?.name ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
                Text(
                  service.customer?.phoneNumber?.toString() ?? '',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Text(
              service.timestamp.toString(),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'option1',
                child: Text('Find Customer'),
              ),
              const PopupMenuItem<String>(
                value: 'option2',
                child: Text('Delete Service'),
              ),
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
              SelectorWidget(serviceState: service.state),
              Wrap(
                direction: Axis.horizontal,
                spacing: 4,
                children:
                    service.labels.map((e) => LabelWidget(label: e)).toList(),
              ),
            ],
          ),
          const SectionAddEventWidget(),
          SectionEventsWidget(service: service),
          SectionDescriptionWidget(service: service),
          SectionBelongingsWidget(service: service),
          SectionImagesWidget(service: service),
          SectionCollectedWidget(service: service),
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

class SelectorWidget extends StatefulWidget {
  ServiceState? serviceState;

  SelectorWidget({super.key, required this.serviceState});

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.serviceState?.color ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<ServiceState>(
        value: widget.serviceState,
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        borderRadius: BorderRadius.circular(10),
        underline: const SizedBox(),
        selectedItemBuilder: (context) {
          return [
            ServiceState.PENDING,
            ServiceState.WAITING,
            ServiceState.COMPLETED,
            ServiceState.REJECTED,
          ].map((e) {
            return Row(children: [
              const Icon(Icons.info, color: Colors.white),
              Text(e.title, style: const TextStyle(color: Colors.white)),
            ]);
          }).toList();
        },
        onChanged: (ServiceState? newValue) {
          setState(() => widget.serviceState = newValue!);
        },
        items: <ServiceState>[
          ServiceState.PENDING,
          ServiceState.WAITING,
          ServiceState.COMPLETED,
          ServiceState.REJECTED,
        ].map<DropdownMenuItem<ServiceState>>((ServiceState value) {
          return DropdownMenuItem<ServiceState>(
            value: value,
            child: Text(value.title),
          );
        }).toList(),
      ),
    );
  }
}

class SectionAddEventWidget extends StatelessWidget {
  const SectionAddEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xffdbc6db),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Add Event'),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: null,
                      ),
                      onChanged: (value) => print('Entered text: $value'),
                      maxLines: null,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.image),
                      Divider(color: Colors.black, thickness: 0.2),
                      Text('JimmyChane'),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0,
                    color: const Color(0xFFCCACCC),
                    child: Column(children: [
                      Container(
                        width: double.infinity,
                        color: const Color(0xff961d96),
                        child: const Center(
                          child: Text(
                            'Quotation',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 100,
                        padding: const EdgeInsets.all(8),
                        child: const Row(children: [Text('RM'), Text('0.00')]),
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text('Discard')),
                          TextButton(
                              onPressed: () {}, child: const Text('Enter')),
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionEventsWidget extends StatelessWidget {
  final Service service;

  const SectionEventsWidget({super.key, required this.service});

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
                  ServiceEventLabelWidget(title: 'Label1'),
                  ServiceEventLabelWidget(title: 'Label2'),
                  ServiceEventLabelWidget(title: 'Label3'),
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

class ServiceEventLabelWidget extends StatelessWidget {
  final String title;

  const ServiceEventLabelWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Text('Label1');
  }
}

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

class SectionWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Function? onTapEdit;

  const SectionWidget({
    super.key,
    required this.title,
    required this.body,
    this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (onTapEdit != null)
                    InkWell(
                      onTap: () => onTapEdit!(),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.edit_outlined),
                      ),
                    )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}

class SectionDescriptionWidget extends StatelessWidget {
  final Service service;

  const SectionDescriptionWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Description',
      body: Text(service.description),
      onTapEdit: () {
        BottomSheetWidget.show(
          context,
          title: 'Edit Description',
          widget: Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
              maxLines: null,
              controller: TextEditingController(
                text: service.description,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SectionBelongingsWidget extends StatelessWidget {
  final Service service;

  const SectionBelongingsWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Belongings',
      onTapEdit: () {
        BottomSheetWidget.show(
          context,
          title: 'Edit Belongings',
          widget: SectionBottomSheetBelongings(belongings: service.belongings),
        );
      },
      body: service.belongings.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  service.belongings.map((e) => BelongingWidget(e)).toList(),
            )
          : const Text('Empty', style: TextStyle()),
    );
  }
}

class SectionBottomSheetBelongings extends StatelessWidget {
  final List<Belonging> belongings;

  late final List<Belonging> templates;

  SectionBottomSheetBelongings({required this.belongings}) {
    templates = belongings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: templates
            .map((e) => SectionBottomSheetBelonging(belonging: e))
            .toList(),
      ),
    );
  }
}

class SectionBottomSheetBelonging extends StatelessWidget {
  final Belonging belonging;

  SectionBottomSheetBelonging({required this.belonging});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF7F7F7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0x0D0D0D0F), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: TextEditingController(text: belonging.title),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 80,
                  child: Row(
                    children: [
                      const Text('x'),
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: TextEditingController(
                            text: '${belonging.quantity}',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: TextEditingController(text: belonging.description),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionImagesWidget extends StatelessWidget {
  final Service service;

  const SectionImagesWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SectionWidget(
      title: 'Image Reference',
      body: service.belongings.isNotEmpty
          ? Wrap(
              spacing: 4,
              runSpacing: 4,
              children: service.images.map((e) {
                return FutureBuilder<Uint8List>(
                  future: e.toBlob(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Failed to load image');
                    } else if (snapshot.hasData) {
                      return Stack(
                        children: [
                          Image.memory(snapshot.data!, height: 100),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: PopupMenuButton<String>(
                              onSelected: (value) {
                                print('Selected: $value');
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem<String>(
                                    value: 'edit-description',
                                    child: Text('Delete Image')),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text('No image data');
                    }
                  },
                );
              }).toList(),
            )
          : const Text('No Images', style: TextStyle()),
    );
  }
}

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

class BottomSheetWidget extends StatelessWidget {
  static show(
    BuildContext context, {
    required Widget widget,
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return BottomSheetWidget(widget: widget, title: title);
      },
    );
  }

  final String title;
  final Widget widget;

  const BottomSheetWidget({
    super.key,
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.1),
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Text(title),
                  ],
                ),
              ),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
