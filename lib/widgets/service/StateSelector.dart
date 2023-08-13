import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/State.dart';

class StateSelectorWidget extends StatefulWidget {
  ServiceState? serviceState;
  Function onChanged = (ServiceState? newValue) => {};

  StateSelectorWidget({
    super.key,
    required this.serviceState,
    required this.onChanged,
  });

  @override
  State<StateSelectorWidget> createState() => _StateSelectorWidgetState();
}

class _StateSelectorWidgetState extends State<StateSelectorWidget> {
  List<ServiceState> states = [
    ServiceState.PENDING,
    ServiceState.WAITING,
    ServiceState.COMPLETED,
    ServiceState.REJECTED,
  ];

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
          return states.map((e) {
            return Row(children: [
              const Icon(Icons.info, color: Colors.white),
              Text(e.title, style: const TextStyle(color: Colors.white)),
            ]);
          }).toList();
        },
        onChanged: (ServiceState? newValue) => widget.onChanged(newValue),
        items: states.map<DropdownMenuItem<ServiceState>>(
          (ServiceState value) {
            return DropdownMenuItem<ServiceState>(
              value: value,
              child: Text(value.title),
            );
          },
        ).toList(),
      ),
    );
  }
}
