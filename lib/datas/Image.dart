import 'dart:typed_data';

import 'package:freshnet_flutter/logics/Api.dart';
import 'package:freshnet_flutter/logics/Login.dart';
import 'package:http/http.dart' as http;

class ServiceImage {
  String name = '';
  String path = '';
  String method = '';
  String storageType = '';

  fromData(data) {
    name = data['name'];
    path = data['path'];
    method = data['method'];
    storageType = data['storageType'];

    return this;
  }

  Future<Uint8List> toBlob() async {
    final String apiUrl = '${Api.HOST}/service_v2/get/image';
    final String url = '$apiUrl/$name';
    final String token = await Login.getLocalToken() ?? '';

    final response = await http.get(
      Uri.parse(url),
      headers: {'authorization': token},
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch Blob data');
    }
  }
}
