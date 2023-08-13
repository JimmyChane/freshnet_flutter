import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/State.dart';

class TabsWidget extends StatefulWidget {
  final Function? onTabChanged;

  const TabsWidget({super.key, this.onTabChanged});

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  List<ServiceState> tabs = [
    ServiceState.PENDING,
    ServiceState.WAITING,
    ServiceState.COMPLETED,
    ServiceState.REJECTED,
  ];
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          return TabWidget(
            tab: tabs[index],
            isSelected: current == index,
            onTap: () => setState(() {
              current = index;
              widget.onTabChanged!(tabs[index]);
            }),
          );
        },
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  final ServiceState tab;
  final bool isSelected;
  final Function onTap;

  const TabWidget({
    super.key,
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(5),
      color: isSelected ? tab.color : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(isSelected ? 15 : 10),
        onTap: () => onTap(),
        child: SizedBox(
          width: 140,
          child: Center(
            child: Text(
              tab.title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
