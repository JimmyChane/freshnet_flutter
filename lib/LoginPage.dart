import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:freshnet_flutter/ServicesPage.dart';
import 'package:freshnet_flutter/Token.dart';

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

  void login() async {
    final user = await Token.login(username, password);

    if (user == null) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ServicesPage()),
    );
  }
}
