import 'package:flutter/material.dart';
import 'package:freshnet_flutter/widgets/login/LoginPage.dart';
import 'package:freshnet_flutter/widgets/service/ServicePage.dart';
import 'package:freshnet_flutter/logics/Login.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshnet Enterprise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Login.verifyLocalToken(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data == false) {
            return LoginPage();
          }
          return const ServicesPage();
        },
      ),
    );
  }
}
