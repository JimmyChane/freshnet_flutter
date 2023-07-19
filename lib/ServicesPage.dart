import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:freshnet_flutter/LoginPage.dart';
import 'package:freshnet_flutter/ServicePage.dart';
import 'package:freshnet_flutter/Token.dart';
import 'dart:convert';
import 'Data.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  _ServicesPageState() {
    fetchServices();
  }

  List<Service> services = [];
  List<Service> tabServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Services'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'logout') {
                Token.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: Column(
            children: [
              TabsWidget(onTabChanged: onTabChanged),
              ServicesWidget(services: tabServices)
            ],
          ),
        ),
      ),
    );
  }

  fetchServices() async {
    List<Service>? list = await Services.getList();
    if (list == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return;
    }

    setState(() {
      services = list;
      onTabChanged(ServiceState.PENDING);
    });
  }

  onTabChanged(ServiceState tab) {
    setState(() {
      tabServices = services.where((element) => element.state == tab).toList();
    });
  }
}

class TabsWidget extends StatefulWidget {
  Function? onTabChanged;

  TabsWidget({super.key, this.onTabChanged});

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

class ServicesWidget extends StatelessWidget {
  final List<Service> services;

  const ServicesWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          ...services.map((service) => ServiceWidget(service)).toList().reversed
        ],
      ),
    );
  }
}

class ServiceWidget extends StatelessWidget {
  final Service service;

  const ServiceWidget(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicePage(service: service),
            ),
          );
        },
        child: SizedBox(
          height: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: service.state.color),
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
