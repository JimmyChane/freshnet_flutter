import 'package:flutter/material.dart';
import 'package:freshnet_flutter/widgets/service/ServicePage.dart';
import 'package:freshnet_flutter/logics/Login.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              controller: TextEditingController(text: username),
              onChanged: (value) => username = value,
            ),
            const SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              controller: TextEditingController(text: password),
              onChanged: (value) => password = value,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => login(),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<T?> routeTo<T extends Object?, TO extends Object?>(Route<T> newRoute,
      {TO? result}) {
    return Navigator.pushReplacement(context, newRoute);
  }

  void login() async {
    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You must enter username'),
        duration: Duration(seconds: 3),
      ));
      return;
    }
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You must enter password'),
        duration: Duration(seconds: 3),
      ));
      return;
    }

    final user = await Login.login(username, password);

    if (user == null) {
      const snackBar = SnackBar(
        content: Text('Login Failed'),
        duration: Duration(seconds: 3),
      );

      showSnackBar(snackBar);

      return;
    }

    routeTo(MaterialPageRoute(builder: (context) => const ServicesPage()));
  }
}
