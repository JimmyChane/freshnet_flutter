import 'package:flutter/material.dart';

class PanelAddServiceWidget extends StatelessWidget {
  final String name = 'Jimmy';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Card(
            color: const Color(0xffeeeeee),
            shape: const RoundedRectangleBorder(
              side: BorderSide(width: 0.1),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text('Admin: $name'),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Customer'),
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: null,
              ),
            ],
          ),
          const Text('Belonging'),
        ],
      ),
    );
  }
}
