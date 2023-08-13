import 'package:flutter/material.dart';
import 'package:freshnet_flutter/datas/State.dart';
import 'package:freshnet_flutter/widgets/login/LoginPage.dart';
import 'package:freshnet_flutter/logics/Login.dart';
import 'package:freshnet_flutter/datas/Service.dart';
import 'package:freshnet_flutter/widgets/service/BottomSheetService.dart';
import 'package:freshnet_flutter/widgets/service/Services.dart';
import 'package:freshnet_flutter/widgets/service/TabLayout.dart';
import 'package:freshnet_flutter/widgets/service/panel/PanelAddService.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Service> services = [];
  List<Service> tabServices = [];

  @override
  void initState() {
    super.initState();
    reloadServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => clickAddService(),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'refresh':
                  reloadServices();
                  break;
                case 'logout':
                  Login.clearLocalToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                  value: 'refresh', child: Text('Refresh')),
              const PopupMenuItem<String>(
                  value: 'logout', child: Text('Logout')),
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
              ServicesWidget(services: tabServices),
            ],
          ),
        ),
      ),
    );
  }

  goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  clickAddService() {
    BottomSheetServiceWidget.show(
      context,
      title: 'Add Service',
      widget: PanelAddServiceWidget(),
    );
  }

  reloadServices() async {
    List<Service>? list = await Service.getList();
    if (list == null) {
      goToLoginPage();
      return;
    }

    setState(() {
      services = list;
      onTabChanged(ServiceState.PENDING);
    });
  }

  onTabChanged(ServiceState tab) {
    setState(() {
      tabServices = services.where((element) {
        return element.state == tab;
      }).toList();
    });
  }
}
