import 'dart:convert';

import 'Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login {
  static Future login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return;
    }

    final response = await http.post(
      Uri.parse('${Api.HOST}/session/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      print('Login failed. Error code: ${response.statusCode}');
      return;
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> content = data['content'];

    final String token = content['token'];
    final Map<String, dynamic> user = content['user'];

    await Login.saveLocalToken(token);

    return user;
  }

  static Future<String?> getLocalToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> verifyLocalToken() async {
    final String? storedToken = await getLocalToken();

    if (storedToken == null) return false;

    final response = await http.post(
      Uri.parse('http://localhost/session/verifyToken'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': storedToken}),
    );

    if (response.statusCode != 200) return false;

    final Map<String, dynamic> data = jsonDecode(response.body);
    final Map<String, dynamic> content = data['content'];

    final Map<String, dynamic> user = content['user'];

    return true;
  }

  static Future clearLocalToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future saveLocalToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
