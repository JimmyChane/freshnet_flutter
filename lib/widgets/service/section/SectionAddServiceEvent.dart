import 'package:flutter/material.dart';

class SectionAddServiceEventWidget extends StatelessWidget {
  const SectionAddServiceEventWidget({super.key});

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
